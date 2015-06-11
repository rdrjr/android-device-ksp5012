/*
 * KSP5014 CPLD SPI Bus Mux Application
 *
 * Copyright (c) 2015  Russell Robinson <rrobinson@phytec.com>
 *
 * based on:
 *
 * SPI testing utility (using spidev driver)
 *
 * Copyright (c) 2007  MontaVista Software, Inc.
 * Copyright (c) 2007  Anton Vorontsov <avorontsov@ru.mvista.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License.
 *
 * Cross-compile with cross-gcc -I/path/to/cross-kernel/include
 */


#include <stdint.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include "spidev.h"

#define CPLD_DEVICE "/dev/spidev1.0"

#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
#define CPLD_SPI_BITS (16)
#define CPLD_SPI_SPD  (24000000)

struct cpld_data {
	char* target;
	uint16_t data;
};

static struct cpld_data cpld_d;

static void pabort(const char *s)
{
	perror(s);
	abort();
}

/* calls i2c command to Raman Power Micro to mux the CPLD signals
 *
 * input: target_index comes from targets array in parse_opts()
 */
#define CHARGER   (0)
#define LASER_TE  (1)
#define LASER_CUR (2)
#define IMAGER_TE (3)
static void raman_target_mux(int target_index)
{
	switch (target_index) {
	case CHARGER:
		system("echo spi_bus_sel 00 00 > /sys/bus/i2c/devices/1-0059/write_reg");
		break;
	case LASER_TE:
		system("echo spi_bus_sel 01 00 > /sys/bus/i2c/devices/1-0059/write_reg");
		break;
	case LASER_CUR:
		system("echo spi_bus_sel 02 00 > /sys/bus/i2c/devices/1-0059/write_reg");
		break;
	case IMAGER_TE:
		system("echo spi_bus_sel 03 00 > /sys/bus/i2c/devices/1-0059/write_reg");
		break;
	}
}

static void cpld_write(int fd)
{
	int ret;
	uint8_t tx[2];

	tx[1] = (cpld_d.data >> 8);
	printf("tx[1] = 0x%02x\n", tx[1]);
	tx[0] = (cpld_d.data & 0xff);
	printf("tx[0] = 0x%02x\n", tx[0]);

	struct spi_ioc_transfer tr = {
		.tx_buf = (unsigned long)tx,
		.len = ARRAY_SIZE(tx),
		.speed_hz = CPLD_SPI_SPD,
		.bits_per_word = CPLD_SPI_BITS,
	};

	ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
	if (ret < 1)
		pabort("cannot send SPI message");


	printf("%s DAC set to %d\n", cpld_d.target, cpld_d.data);
}

static void print_usage(const char *prog)
{
	printf("Usage: %s [-trdm]\n", prog);
	puts("  -t --target   CPLD SPI target\n"
             "      (charger, laser_te, laser_cur, imager_te)\n"
	     "  -d --data     data value to write to DAC [0-4095]\n");

	exit(1);
}

static void parse_opts(int argc, char *argv[])
{
	int i;
	int tflag = 0;
	int dflag = 0;
	char* targets[] = {"charger", "laser_te", "laser_cur", "imager_te"};

	while (1) {
		static const struct option lopts[] = {
			{ "target", 1, 0, 't' },
			{ "data",   1, 0, 'd' },
			{ NULL, 0, 0, 0 },
		};
		int c;

		c = getopt_long(argc, argv, "t:d:", lopts, NULL);

		if (c == -1)
			break;

		switch (c) {
		case 't':
			tflag = 1;
			cpld_d.target = optarg;
			break;
		case 'd':
			dflag = 1;
			cpld_d.data = atoi(optarg);
			break;
		default:
			print_usage(argv[0]);
			break;
		}
	}

	if (!tflag && !dflag) {
		printf("%s: missing SPI bus target and "
				"DAC data value\n", argv[0]);
		print_usage(argv[0]);
	} else if (!tflag) {
		printf("%s: missing SPI bus target\n", argv[0]);
		print_usage(argv[0]);
	} else if (!dflag) {
		printf("%s: missing DAC data value\n", argv[0]);
		print_usage(argv[0]);
	}

	if (cpld_d.data > 4095) {
		printf("%s: DAC data value is outside the 0-4095 range\n", argv[0]);
		exit(1);
	}

	for (i = 0; i < (int) ARRAY_SIZE(targets); i++) {
		if (!strcmp(cpld_d.target, targets[i])) {
			raman_target_mux(i);
			return;
		}
	}

	printf("%s: SPI bus target is invalid\n", argv[0]);
	print_usage(argv[0]);
}

int main (int argc, char* argv[])
{
	const char* device = CPLD_DEVICE;
	int ret = 0;
	int fd;

	uint32_t mode = SPI_MODE_1;
	uint8_t bits = CPLD_SPI_BITS;
	uint32_t speed = CPLD_SPI_SPD;
 
	parse_opts(argc, argv);

	/* open spi device */
	fd = open(device, O_WRONLY);
	if (fd < 0)
		pabort("cannot open SPI device\n");

	/* spi mode */
	ret = ioctl(fd, SPI_IOC_WR_MODE, &mode);
	if (ret < 0)
		pabort("cannot set spi mode");

	/* bits per word */
	ret = ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &bits);
	if (ret < 0)
		pabort("cannot set bits per word");

	/* max speed hz */
	ret = ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &speed);
	if (ret < 0)
		pabort("cannot set max speed hz");

	cpld_write(fd);	

	close(fd);

	return ret;
}

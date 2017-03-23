# Coursera Exploratory Data Science
#
# Week 1 Programming Assignment
#
# Create plot 1
#

# Load data from file into cons_two_days
library(readr)
library(dplyr)

consumption_data <- read_delim("household_power_consumption.txt",
                delim = ";",
                na    = "?",
                col_types = cols(Date                  = col_date(format = "%d/%m/%Y"),
                                 Time                  = col_time(format = "%H:%M:%S"),
                                 Global_active_power   = col_double(),
                                 Global_reactive_power = col_double(),
                                 Voltage               = col_number(),
                                 Global_intensity      = col_double(),
                                 Sub_metering_1        = col_double(),
                                 Sub_metering_2        = col_double(),
                                 Sub_metering_3        = col_double()
                                 )
               )

cons_two_days          <- filter(consumption_data, Date == "2007-02-01" | Date == "2007-02-02")
cons_two_days$datetime <- as.POSIXlt(cons_two_days$Date) + cons_two_days$Time


# Open png file
png(filename="plot1.png", width = 480, height = 480)

# Create the plot
with(cons_two_days,
     hist(Global_active_power,
          col  = "red",
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)")
     )

# Close the png file
dev.off()

# Coursera Exploratory Data Science
#
# Week 1 Programming Assignment
#
# Create plot 4
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
png(filename="plot4.png", width = 480, height = 480)

# set the number of rows and columns
par(mfrow=c(2,2))

#
# plot top left
#
with(cons_two_days, plot(datetime, Global_active_power, type = "l",
                         xlab = "",
                         ylab = "Global Active Power"))

#
# plot top right
#
with(cons_two_days, plot(datetime, Voltage, type = "l"))

#
# plot bottom left
#
with(cons_two_days, {
         plot(datetime, Sub_metering_1, type = "l", col  = "black",
              xlab = "",
              ylab = "Energy sub metering")
       points(datetime, Sub_metering_2, type = "l", col  = "red")
       points(datetime, Sub_metering_3, type = "l", col  = "blue")
     })

legend("topright",
       col    = c("black", "red", "blue"),
       legend = c("Sub_metering_1","Sub_metering_3","Sub_metering_3"),
       lty    = 1)


#
# plot bottom right
#
with(cons_two_days, plot(datetime, Global_reactive_power, type = "l"))

# Close the png file
dev.off()

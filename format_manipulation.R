###### first source bouts.R script for data/ load ethoscope data

library(sleepr)
library(ggetho)

moving_bout_dt <- bout_analysis(moving, dt) # get bout data by moving variable (eliminates the 5 min rule)

moving_bout_dt[, sex := xmv(sex)] #adding a sex variable to the data (useful for ggplots and data manipulation later)

moving_bout_dt[,t_h := floor(t/hours(1))] #converting time of day from seconds to hours, floor hours to deal with bout durations that are overlap between hours

moving_bout_dt[,wrapped_t_h := (t_h %% 24) + 1] #wrapping hours to fit within course of one day and shifting by 1 for hours to go from 1 to 24, as opposed to 1 to 23. (modulo by hours(24) doesn't work but theoretically should be fine at this stage)


moving_bout_dt$t_h <- NULL #remove the intermediate t_h column, not needed anymore

moving_bout_dt

#check for missing values in data
sapply(moving_bout_dt, function(x)all(any(is.na(x)))) #don't have any

saveRDS(moving_bout_dt, "moving_bouts")

# NOW READY DATASET FOR ANALYSIS 

#for easier future use split up wake bouts and sleep bouts and save as R variables

wake_bouts <- moving_bout_dt[ moving == TRUE, -'moving']
sleep_bouts <- moving_bout_dt[ moving == FALSE, -'moving']

saveRDS(wake_bouts, "wake_bouts")
saveRDS(sleep_bouts, "sleep_bouts")

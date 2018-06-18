rm(list=ls());gc()

library(scopr)
library(ggetho)
library(sleepr)
library(cowplot)

METADATA <- "metadata.csv"
CACHE <- "./cache/"
RESULT_DIR <- "./raw_results"


### source of data removed for data protection purposes ###

N_PROTOTYPE <- 200
met <- fread(METADATA)
met <- met[status == "OK" & sdi ==0]  #only get flies with OK status and no sleep deprivation
#download relevant files from remote directory
set.seed(321); sample <- sample(1:nrow(met),size = N_PROTOTYPE, replace = F)
met <- met[sample]


met <- link_ethoscope_metadata_remote(met,
                                      remote_dir =  REMOTE_DIR,
                                      result_dir = RESULT_DIR,
                                      verbose = TRUE)
#verbose = TRUE to see printing in progress

#~ met_init <- link_ethoscope_metadata(met, result_dir = RESULT_DIR)
                                      
                                                                            
dt <- load_ethoscope(  met,
					   max_time = days(7),
					   reference_hour = 9.0,
					   cache = CACHE,
					   FUN = sleep_annotation,
					   ncores=1)
# sleep annotation function from sleepr - quantify activity in windows of 10s
#activity in each 10s of data will be scored + position will be kept, sleep scored according to '5 min rule'
#FUN - applying function to all data
#pulls out saved items from cache
#express time relative to ZT0( i.e. the hour of the day when the L phase starts). In Giorgio's lab = 9:00:00:00 GMT. That's what reference hour (9.0) is. 

summary(dt)
                 
                 

   
curate_data <- function(data){
  data[, t := t - days(xmv(baseline_days))]
  data <- data[is_interpolated == F]
	# first we remove animals that do not have enough data points
	valid_animals <- data[,.(t_range = max(t) - min(t)), by=id][t_range >= days(5)]$id
	data <- data[t > days(-2) & 
				 t < days(+2) &
				 id %in% valid_animals]
	data[, t := t+ days(2)]
	# data <- data[xmv(sdi)==0]
#~ 	data[,x_rel := ifelse(xmv(region_id) > 10, 1-x, x)]

#~ 	norm_x <- function(x){
#~ 		min_x <- quantile(na.omit(x),probs=0.01)
#~ 		x <- x - min_x
#~ 		max_x <- quantile(na.omit(x),probs=0.99)
#~ 		x / max_x
#~ 		}
#~ 	data[, x_rel := norm_x(x_rel), by=id]
}

# then we apply this function to our data
dt <- curate_data(dt)

# Based on a post (https://www.r-bloggers.com/roc-curves/) 


# ROC curves were invented during WWII to help radar operators decide whether the signal they were  
# getting indicated the presence of an enemy aircraft or was just noise. 

#--------------------------------------------------------------------------------------------------
# 1. Loading packages 
#--------------------------------------------------------------------------------------------------

library(tidyverse)
library(gganimate)  # for animation
library(magick)     # to put animations sicde by side
library(reprex)
library(gifski)     # renderer      

#--------------------------------------------------------------------------------------------------
# 2. Generating noise and signal plus noise
#--------------------------------------------------------------------------------------------------

# We model the noise alone as random draws from a N(0,1) distribution, signal plus noise as draws from N(s_mean, S_sd), 
# and we compute two conditional distributions. 
# The probability of a “Hit” or P(X > c | a signal is present) and the probability of a “False Alarm”, P(X > c | noise only).


s_mean <- 2  # signal mean , as the mean increases, the signal curve is better separated from the noise one 
                                # and the ROC angle increases, too, giving the look of the perfect model. (say if you try mean = 5)
                                        # and then you wake up -- same old crappy observations
s_sd <- 1.1   # signal standard deviation

x <- seq(-5,5,by=0.01)                  # range of signal
signal <- rnorm(100000,s_mean,s_sd)
noise <- rnorm(100000,0,1)

PX_n  <- 1 - pnorm(x, mean = 0, sd = 1)         # P(X > c | noise only) = False alarm rate
PX_sn <- 1 - pnorm(x, mean = s_mean, sd = s_sd) # P(X > c | signal plus noise) = Hit rate

#--------------------------------------------------------------------------------------------------
# 3. Generating the animation plots
#--------------------------------------------------------------------------------------------------

threshold <- data.frame(val = seq(from = .5, to = s_mean, by = .2)) # We plot these two distributions in the left panel of the animation  
                                                                    # - for different values of the cutoff threshold 

dist <- 
        data.frame(signal = signal, noise = noise) %>% 
        gather(data, value) %>% 
        ggplot(aes(x = value, fill = data)) +
        geom_density(trim = TRUE, alpha = .5) +
        ggtitle("Conditional Distributions") +
        xlab("Observed signal")  + ylab("Density") +
        scale_fill_manual(values = c("white", "darkblue"))

p1 <- dist + geom_vline(data = threshold, xintercept = threshold$val, color = "red", size=1) +
        transition_manual(threshold$val) # That's the red line moving around -- cutoff line
p1 <- animate(p1)




### ROC
df2 <- data.frame(x, PX_n, PX_sn)
roc <- ggplot(df2) +
        xlab("P(X | n)") + ylab("P(X | sn)") +
        geom_line(aes(PX_n, PX_sn)) +
        geom_abline(slope = 1) +
        ggtitle("ROC Curve") + 
        coord_equal()

q1 <- roc +
        geom_point(data = threshold, aes(1-pnorm(val),
                                         1- pnorm(val, mean = s_mean, sd = s_sd)), color = "red", size = 3.5) +
                   
        transition_manual(val)

q1 <- animate(q1)

# Defining function "combine_gifs" to combine the two graphs -- can be found at (https://github.com/thomasp85/gganimate/issues/226)

combine_gifs <- function(plot1, plot2) {
        require(magick) 
        # read the plots and store them
        plot1 <- image_read(plot1) 
        plot2 <- image_read(plot2) 
        # sync the number of frames in each plot
        n1 = length(plot1)
        n2 = length(plot2)
        # match number of frames of the two plots
        if (!(n1 == n2)) plot1 <- rep(plot1, n2) 
        if (!(n1 == n2)) plot2 <- rep(plot2, n1)
        # initialize the combined plot
        p <- image_append(c(plot1[1], plot2[1]))
        # grow the combined plot frame by frame
        n = ifelse(n1 == n2, n1, n1 * n2) 
        n = min(1000, n)  # set max to 1000
        for (i in 2:(n-1)) {
                tmp <- image_append(c(plot1[i], plot2[i]))
                p <- c(p, tmp)
        }
        return(p) 
}
combine_gifs(p1,q1) # Press "Show in new window" to view the plots externally

#--------------------------------------------------------------------------------------------------
# ?. Why did we do all that
#--------------------------------------------------------------------------------------------------

# The animation plots showcase the fundamental tradeoff between hit rate and false alarm
# As the cutoff moves to the right it gives the decision maker the chance to make a more accurate decision (not false alarm)
# However, as the accuracy of decision increases, the hit rate is decreasing

# Computing the area under the ROC curve -- AUC -- has been the standard in decision theory and classifier selection
# However, one cannot select a classifier based on the AUC only -- AUC != accuracy

# What does the AUC measure? For the binary classification problem of our simple signal processing example, 
# a little calculus will show that the AUC is the probability that a randomly drawn interval with a signal 
# present will produce a higher X value than a signal interval containing noise alone
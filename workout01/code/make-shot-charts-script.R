##Title: Shot Charts
##Description: For the shot charts part, we basically do with the creation of shot charts.
##Inputs: shots-data.csv
##Outputs: andre-iguodala-shot-chart.pdf, draymond-green-shot-chart.pdf, kevin-durant-shot-chart.pdf, klay-thompson-shot-chart.pdf, 
##      stephen-curry-shot-chart.pdf, gsw-shot-charts.pdf, gsw-shot-charts.png
###
library(ggplot2)
library(jpeg)
library(grid)

total <- read.csv("Desktop/workout01/data/shots-data.csv", stringsAsFactors = FALSE)
curry <- subset(total, name == "Stephen Currry")
thompson <- subset(total, name == "Klay Thompson")
durant <- subset(total, name == "Kevin Durant")
green <- subset(total, name == "Draymond Green")
andre <- subset(total, name == "Andre Iguodala")

curry_plot <- ggplot(data=curry)+
  geom_point(aes(x = x, y = y, color = shot_made_flag))
thom_plot <- ggplot(data=thompson)+
  geom_point(aes(x = x, y = y, color = shot_made_flag))
durant_plot <- ggplot(data=durant)+
  geom_point(aes(x = x, y = y, color = shot_made_flag))
green_plot <- ggplot(data=green)+
  geom_point(aes(x = x, y = y, color = shot_made_flag))
andre_plot <- ggplot(data=andre)+
  geom_point(aes(x = x, y = y, color = shot_made_flag))

court_file <- "Desktop/workout01/images/nba-court.jpg"
court_image <- rasterGrob(readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))

curry_shot_chart <- ggplot(data = curry) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Currry (2016 season)') + 
  theme_minimal()
ggsave(filename = "Desktop/workout01/images/stephen-curry-shot-chart.pdf",
       plot = curry_shot_chart, width = 6.5, height = 5)

thom_shot_chart <- ggplot(data = thompson) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') + 
  theme_minimal()
ggsave(filename = "Desktop/workout01/images/klay-thompson-shot-chart.pdf",
       plot = thom_shot_chart, width = 6.5, height = 5)

durant_shot_chart <- ggplot(data = durant) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') + 
  theme_minimal()
ggsave(filename = "Desktop/workout01/images/kevin-durant-shot-chart.pdf",
       plot = durant_shot_chart, width = 6.5, height = 5)

green_shot_chart <- ggplot(data = green) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') + 
  theme_minimal()
ggsave(filename = "Desktop/workout01/images/draymond-green-shot-chart.pdf",
       plot = green_shot_chart, width = 6.5, height = 5)

andre_shot_chart <- ggplot(data = andre) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') + 
  theme_minimal()
ggsave(filename = "Desktop/workout01/images/andre-iguodala-shot-chart.pdf",
       plot = andre_shot_chart, width = 6.5, height = 5)

gsw_shot_chart <- ggplot(data = total) + 
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart For GSW (2016 season)') + 
  theme_minimal()+ facet_wrap(~name, ncol = 3)
ggsave(filename = "Desktop/workout01/images/gsw-shot-charts.pdf", width = 8, height = 7)
ggsave(filename = "Desktop/workout01/images/gsw-shot-charts.png", width = 8, height = 7)
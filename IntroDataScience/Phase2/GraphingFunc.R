educ.bar <- myData %>%
  count <- n()
  mutate(perc.educ = 100*n/sum(n)) %>%
  ggplot(aes(x = educClean, fill = educ,
             y = perc.educ)) +
  geom_col(position = 'dodge') +
  theme_classic() +
  scale_fill_manual(values = c("#88398a", 'gray40'),
                    name = "Education Level of Respondents") +
  labs(x = "Level of Education",
       y = "Percent of responses")
educ.bar

myData <- data.frame(educClean, fair, happy, helpful, life, trust)


educ.bar <- myData %>%
  ggplot(aes(x=educClean)) +
  geom_bar(stat="count", fill ="#88398a", color="gray40", alpha=0.9) +
  ggtitle("Education Level") +
  theme(axis.text.x = element_text(angle = 75, vjust= 1, hjust = 1)) +
  labs(x="Years of Education",
       y="Number of Responses") +

fair.hist <- myData %>%
  ggplot(aes(x=fairClean)) +
  geom_dotplot(fill = "cornflowerblue") +
  labs(title = "Percieved Fairness",
       y = "Number of Responses",
       x = "Fairness") +
  theme(axis.text.x = element_text(angle = 75, vjust= 1, hjust = 1))

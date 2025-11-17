library(e1071)
library(ggplot2)

#Descriptive stats for EDUC
IQR(gss2022$EDUC, na.rm = TRUE)
kurtosis(gss2022$EDUC, na.rm = TRUE)
range(gss2022$EDUC, na.rm = TRUE)
skewness(gss2022$EDUC, na.rm = TRUE)

# Descriptive stats for HAPPY
IQR(gss2022$HAPPY, na.rm = TRUE)
kurtosis(gss2022$HAPPY, na.rm = TRUE)
range(gss2022$HAPPY, na.rm = TRUE)
skewness(gss2022$HAPPY, na.rm = TRUE)

# Descriptive stats for LIFE
IQR(gss2022$LIFE, na.rm = TRUE)
kurtosis(gss2022$LIFE, na.rm = TRUE)
range(gss2022$LIFE, na.rm = TRUE)
skewness(gss2022$LIFE, na.rm = TRUE)

# Descriptive stats for HELPFUL
IQR(gss2022$HELPFUL, na.rm = TRUE)
kurtosis(gss2022$HELPFUL, na.rm = TRUE)
range(gss2022$HELPFUL, na.rm = TRUE)
skewness(gss2022$HELPFUL, na.rm = TRUE)

# Descriptive stats for FAIR
IQR(gss2022$FAIR, na.rm = TRUE)
kurtosis(gss2022$FAIR, na.rm = TRUE)
range(gss2022$FAIR, na.rm = TRUE)
skewness(gss2022$FAIR, na.rm = TRUE)

# Descriptive stats for TRUST
IQR(gss2022$TRUST, na.rm = TRUE)
kurtosis(gss2022$TRUST, na.rm = TRUE)
range(gss2022$TRUST, na.rm = TRUE)
skewness(gss2022$TRUST, na.rm = TRUE)


library(ggplot2)

ggplot(gss2022, aes(x = EDUC, y = HAPPY)) +
  geom_point() +
  labs(
    title = "Point Chart",
    x = "Education level in year",
    y = "Happiness Level"
  ) + geom_smooth(method = "lm", color = "red", se = FALSE)

ggplot(gss2022, aes(x = EDUC, y = TRUST)) +
  geom_point() +
  labs(
    title = "Point Chart",
    x = "Education level in year",
    y = "Trust in others"
  ) + geom_smooth(method = "lm", color = "red", se = FALSE)

ggplot(gss2022, aes(x = EDUC, y = LIFE)) +
  geom_point() +
  labs(
    title = "Point Chart",
    x = "Education level in year",
    y = "General outlook on life"
  ) + geom_smooth(method = "lm", color = "red", se = FALSE)
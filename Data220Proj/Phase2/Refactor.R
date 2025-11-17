educClean <- recode_factor(.x=educ,
                              '0' = 'No traditional schooling',
                              '1' = '1st Grade',
                              '2' = '2nd Grade',
                              '3' = '3rd Grade',
                              '4' = '4th Grade',
                              '5' = '5th Grade',
                              '6' = '6th Grade',
                              '7' = '7th Grade',
                              '8' = '8th Grade',
                              '9' = '9th Grade',
                              '10'= '10th Grade',
                              '11'= '11th Grade',
                              '12'= '12th Grade',
                              '13'= '1 Year of College',
                              '14'= '2 Years of College',
                              '15'= '3 Years of College',
                              '16'= '4 Years of College',
                              '17'= '5 Years of College',
                              '18'= '6 Years of College',
                              '19'= '7 Years of College',
                              '20'= '8 Years of College')

fairClean <- recode_factor(.x=fair,
                 '1' = 'Advantage',
                 '2' = 'Fair',
                 '3' = 'Depends')

happyClean <- recode_factor(.x=happy,
                            '1' = 'Very Happy',
                            '2' = 'Pretty Happy',
                            '3' = 'Not Happy')

helpfulClean <- recode_factor(.x=helpful,
                              '1' = 'Helpful',
                              '2' = 'Unhelpful',
                              '3' = 'Depends')

trustClean <- recode_factor(.x=trust,
                            '1' = 'Trust',
                            '2' = 'Careful',
                            '3' = 'Depends')

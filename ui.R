shinyUI(pageWithSidebar(
        headerPanel("Simulated t-test"),
        sidebarPanel(
                sliderInput('mu', 'Enter the true mean',value = 0, min = -10, max = 10, step = 0.05,),
                sliderInput('sigma', 'Enter the true standard deviation',value = 1, min = 1, max = 20, step = 0.05,),
                sliderInput('N', 'Enter the sample size',value = 25, min = 1, max = 100, step = 1,),
                sliderInput('hypmu', 'Enter the hypothesized mean',value = 0, min = -10, max = 10, step = 0.05,),
                h3('Documentation'),
                p('This application generates a random dataset in order to simulate an inferential test (t-test) comparing the sample mean to a particular value.'),
                p('You can enter the true mean and standard deviation for the population, the sample size, and the hypothesized value to compare to the sample mean.'),
                p('The output will display the sampling distribution (probability of all possible sample means) and a histogram of the random data.'),
                p('It will also show the mean of the random sample, and calculate a t-value comparing that mean to the true population mean.'),
                p('The p-value associated with the t-test is the proportion of area in the tails of the distribution. Note that this is a 2-tailed test, so the p-value is twice the area shown in the tail beyond the sample mean (the red line).'),
                p('Typically, the p-value is compared to a significance level (the "alpha level") in order to reject a Null Hypotheses (of no difference between the means) or not.'),                
                p('In particular, this can be used to run repeated hypothesis tests in order to demonstrate statistical power, and to simulate the occurance of Type I and Type II errors (see http://en.wikipedia.org/wiki/Type_I_and_type_II_errors for an explanation of these error types).')
                ),
        mainPanel(
                h2('Results of simulation'),
                plotOutput('newPlot'),
                h4('The true mean is'),
                verbatimTextOutput("outmu"),
                h4('The true standard deviation is'),
                verbatimTextOutput("outsigma"),
                h4('The sample size is'),
                verbatimTextOutput("outN"),
                h4('The hypothesized mean is'),
                verbatimTextOutput("outhypmu"),
                h4('The sample mean is'),
                verbatimTextOutput("outxbar"),
                h4('The value of t is'),
                verbatimTextOutput("outt"),
                h4('The p-value is'),
                verbatimTextOutput("outp")                
        )))

library(shiny)

shinyServer( function(input, output) {

        # Get parameters from user
        muInput <- reactive(mu <- input$mu)
        sigmaInput <- reactive(sigma <- input$sigma)
        NInput <- reactive(N <- input$N)
        hypmuInput <- reactive(hypmu <- input$hypmu)
        
        # sigx is the "real" SD of the sampling distribution (i.e., what the SE estimates)
        sigxGet <- reactive(sigx <- sigmaInput()/sqrt(NInput()))
        
        # Generate sample from parameters
        sampGet <- reactive(samp <- rnorm(NInput(), mean=muInput(), sd=sigmaInput()))
        xbarGet <- reactive(xbar <- mean(sampGet()))
        sGet <- reactive(s <- sd(sampGet()))
        seGet <- reactive(se <- sGet()/sqrt(NInput()))
        
        # Make plot with curve, histogram, and location of xbar
        output$newPlot <- renderPlot({
                # Find the highest point on the curve, then plot
                maxHeight <- dnorm(hypmuInput(), mean=hypmuInput(), sd=sigxGet())
                curve(dnorm(x, mean=hypmuInput(), sd=sigxGet()), min(sampGet()), max(sampGet()), col="blue", main="Sampling Distribution and Sample Histogram", sub="Red Line is Sample Mean", xlab="", ylab="")
                hist(sampGet(), prob=T, add=T)
                xvals=c(xbarGet(),xbarGet())
                yvals=c(0,maxHeight)
                lines(xvals,yvals, col="red")
        })
        
        # Calculate the t-value
        calctGet <- reactive(calct <- (xbarGet()-hypmuInput())/seGet())
        
        # Create all of the output variables
        output$outmu <- renderText(muInput())
        output$outsigma <- renderText(sigmaInput())
        output$outN <- renderText(NInput())
        output$outhypmu <- renderText(hypmuInput())
        output$outxbar <- renderText(xbarGet())
        output$outt <- renderText(calctGet())
        # Calculate the 2-tailed p-value
        output$outp <- renderText(2*pt(abs(calctGet()), NInput()-1, lower.tail=FALSE))
} )

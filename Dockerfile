FROM rocker/shiny:4

# Install R packages required 
# Change the packages list to suit your needs
RUN R -e "install.packages(c('shiny', 'RSelenium', 'httr'), dependencies=TRUE)"

# Copy the Shiny app files into the image
COPY app.R /srv/shiny-server/

# Expose port 3838 for Shiny app
EXPOSE 3838

# Run Shiny app on container start
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app.R', host = '0.0.0.0', port = 3838)"]

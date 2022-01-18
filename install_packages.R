your_platform <- "mac" # Choose one of the following: mac, linux or windows

if (your_platform=="mac"){
  install_type <- "mac.binary"
  options(install.packages.check.source = "no")
} else if (your_platform=="windows"){
  install_type <- "win.binary"
  options(install.packages.check.source = "no")
} else if (your_platform=="linux"){
  install_type <- "source"
  options(install.packages.check.source = "yes")
} else{
  stop(
    paste0(
      "Only one of the following OS is allowed ",
      "'mac', 'linux' or 'windows', ",
      "You chose '", your_platform, "', which is not allowed!"))
}

here_installed <- require("here")

if (isFALSE(here_installed)){
  install.packages("here", type = install_type)
} 

here_installed <- require("here")

if (isFALSE(here_installed)){
  cat(paste0(
    "WARNING! The package 'here' could not be installed!\n",
    "Please execute the following comment and make a screenshop from ",
    "resulting error message:\n",
    "install.packages('here')\n",
    "Then post the screenshot in the Moodle forum!"))
} else {
  cat("Package here has been installed successfully!")
}

required_packages <- c(
  "AER",
  "countrycode",
  "data.table",
  "fitdistrplus",
  "gapminder",
  "ggpubr",
  "ggrepel",
  "haven",
  "ineq",
  "latex2exp",
  "lmtest",
  "MASS",
  "moments",
  "optimx",
  "rmarkdown",
  "rmutil",
  "R.utils",
  "sandwich",
  "scales",
  "texreg",
  "tidyverse",
  "tinytex",
  "tufte",
  "viridis",
  "WDI"
)

for (i in 1:length(required_packages)){
  package_name <- required_packages[i]
  print(package_name)
  install.packages(package_name, type = install_type)
}

package_status_list <- list()
for (i in 1:length(required_packages)){
  package_name <- required_packages[i]
  print(package_name)
  package_installed <- require(package_name, 
                               character.only = T)
  status_frame <- data.frame(package=package_name, 
                             status=package_installed)
  package_status_list[[i]] <- status_frame
}

paket_log <- do.call("rbind", package_status_list)

log_path <- here::here("InstallationLog.txt")
write.table(x = paket_log, file = log_path, row.names = FALSE)

package_status_vector <- paket_log[["status"]]

if (sum(package_status_vector)==length(package_status_vector)){
  print("Excellent! All relevant packages were installed successfully!")
} else{
  cat(paste0(
    "Warning! There were errors when installing some packages!\n",
    "Please have a look into the file 'InstallationLog.txt'.",  
    "It was saved here: \n",
    log_path, "\n",
    "If there are only a few packages with a 'FALSE', please try to install ",
    "them separately by executing:\n",
    "install.packages('PACKAGENAME')\n",
    "and make a screenshot of the resulting error message. ",
    "Then post the screenshot as well as the file 'InstallationLog.txt' in ",
    "the Moodle forum so that we can help you!"))
}

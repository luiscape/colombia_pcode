## Script for registering entity types.
library(xlsx)

# Download latest file from DANE's website.
message('Downloading latest p-code list from DANE.')
latest_update <- as.Date(Sys.time())
url <- paste0('http://www.dane.gov.co/Divipola/ServletReporte?fechaVigencia=', as.character(latest_update))
print(url)
download.file(url, 'data/source/divipola.xlsx', method = 'curl')

message('Loading file ...')
Sys.sleep(5)  # let it sleep for 5 seconds.
# Loading the official list from DANE.
# has to use read.xlsx2 for some reason.
divipola <- read.xlsx2('data/source/divipola.xlsx', sheetIndex = 1, startRow = 5)

message('Creating separate p-code lists.')

iso3 <- 'COL-'

# for departamentos
admin2_list <- data.frame(divipola$Código.Departamento, divipola$Nombre.Departamento)
admin2_list <- unique(admin2_list)
names(admin2_list) <- c('admin2', 'admin2_name')
admin2_list$hdx_pcode <- paste0(iso3, admin2_list$admin2)

# for municipios
admin3_list <- data.frame(divipola$Código.Municipio, divipola$Nombre.Municipio)
admin3_list <- unique(admin3_list)
names(admin3_list) <- c('admin3', 'admin3_name')
admin3_list$hdx_pcode <- paste0(iso3, admin3_list$admin3)

# for centros poblados
admin4_list <- data.frame(divipola$Código.Centro.Poblado, divipola$Nombre.Centro.Poblado)
admin4_list <- unique(admin4_list)
names(admin4_list) <- c('admin4', 'admin4_name')
admin4_list$hdx_pcode <- paste0(iso3, admin4_list$admin4)

# summary table
admin2 <- nrow(admin2_list)
admin3 <- nrow(admin3_list)
admin4 <- nrow(admin4_list)
total <- admin2 + admin3 + admin4
summary <- data.frame(admin2, admin3, admin4, total)

message('Storing CSV files...')
# storing CSV
# Notice that the metropolitan area is ignored from the files.
write.csv(divipola, 'data/col_admin_all.csv', row.names = F)
write.csv(admin2_list, 'data/col_admin2.csv', row.names = F)
write.csv(admin3_list, 'data/col_admin3.csv', row.names = F)
write.csv(admin4_list, 'data/col_admin4.csv', row.names = F)
write.csv(summary, 'summary_table.csv', row.names = F)

message('Done.')
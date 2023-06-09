#################################
# ESTADÍSTICA DESCRIPTIVA CON R #
#################################
rm(list=ls())
# Cargamos los datos como vectores
datos <- c(1,2,5,8,10,14,17,21,25,28,40,45)

# Media muestral
mean(datos)

# Media alpha-podada
mean(datos, trim = 0.1) #--> el trim permite definir el alpha de la poda

# Mediana
median(datos)

# Repetimos pero con última observación cambiando de 45 a 450
datos <- c(1,2,5,8,10,14,170,21,25,28,40,450)
mean(datos) # de 18 a 51.75!!!
mean(datos, trim = 0.1) # resistió!!!
median(datos) # resistió

# Repetimos pero la observación 7 cambiando de 17 a 170
datos <- c(1,2,5,8,10,14,170,21,25,28,40,450)
mean(datos) # la siguen traccionando!!!
mean(datos, trim = 0.1) # esta ya se está rompiendo!!!
median(datos) # esta sigue resistiendo bastante

# La media es muy sensible a estos datos "de mucho peso"
# La mediana es muy resistente
# La media alpha podada ofrece un punto intermedio de resistencia


# Distribución empírica
plot(ecdf(datos)) # Los "saltos" son de 1/n y se dan en los xi de la muestra

datos <- c(1,2,5,8,10,14,17,21,25,28,40,45)
plot(ecdf(datos))

# Con el gráfico es fácil hallar F_n(28), que puede verse como una estimación de P(X<=5)
# Otra forma:
mean(datos<=28) #--> datos<=5 guarda 1(TRUE) en la obs que cumple ser <=5 y un 0 en las que no
#--> por eso, el mean de eso equivale a la suma de esos 1 sobre el n (que es cómo definimos a F_n)

# Varianza muestral
var(datos) #--> Este comando es el que divide por n-1
sd(datos)

# Distancia intercuartílica: hay diferentes formas de estimarlos
# El que usamos en clase es "type=2" (creo)
quantile(datos)
quantile(datos, type=2)

# MAD
mad(datos) 
#--> Para asegurar consistencia, esta función multiplica la MAD que usamos nosotros por la cte=1.4826

# a mano: la MAD es 10
aa <- abs(datos-median(datos))
aa[order(aa)]
median(aa)
mad(datos, constant = 1) #--> con constant = 1, devuelve la que usamos nosotros

# Repetimos pero con última observación cambiando de 45 a 450
datos <- c(1,2,5,8,10,14,17,21,25,28,40,450)
var(datos) # de 206 a 15862.93
quantile(datos) # se mantiene
mad(datos, constant = 1) # se mantiene

# Gráficos
datos <- c(1,2,5,8,10,14,17,21,25,28,40,70)
hist(datos) # Asimetría a derecha
hist(datos, probability = TRUE) #, breaks=10
boxplot(datos) # Asimetría a derecha
plot(density(datos))
qqnorm(datos)
qqline(datos)


# QQ-PLOTS
# El caso normal: qqnorm
normal <- rnorm(100)
qqnorm(normal)
qqline(normal)

# Otras distribuciones: qqplot entre la muestra y los cuantiles de la dist teórica supuesta
exponencial <- rexp(100,2)
qqplot(qexp(ppoints(100), 2), exponencial)
#qexp(ppoints(100), 2) acá generamos los cuantiles de la exponencial 2 que suponemos es la distribución subyacente en la muestra
#hist(qexp(ppoints(100), 2))
abline(0,1)

qqplot(qchisq(ppoints(100), 2), exponencial)
abline(0,1) # da horrible: claramente no podría pensar que la muestra viene de una chi


#########################
# EJERCICIO SÍMIL E1 P6 #
#########################
# Borro resultados anteriores
rm(list=ls())

# Defino mi directorio de trabajo
setwd("G:/Mi unidad/_FCEyN UBA/_PyC2021/_2c2021/_FilminasPracticas/1021_Estadística descriptiva")

# Cargo los datos del quiz
datos <- read.csv("quiz.csv", sep=";")

# Los miro
head(datos)

# Los fijo para poder llamarlos directamente
attach(datos)
Nota
P5

# 1) Estimar la probabilidad de responder correctamente la pregunta 5: quiero estimar P(Y=1)
mean(P5)

# 2) Estimar la probabilidad de responder correctamente la pregunta 5 y sacarse un 9: quiero estimar P(X=9,Y=1)
datos[Nota==9 & P5==1,]

n <- nrow(datos)
nrow(datos[Nota==9 & P5==1,])/n

# 3) Estimar la función de probabilidad puntual conjunta del vector (X,Y): quiero estimar pXY(X,Y)
t <- t(table(Nota, P5))
t

pXY <- t/n

sum(pXY)

# 4) Estimar la esperanza y la varianza de X: quiero estimar E(X), V(X)
mean(Nota)
var(Nota)

# 5) Estimar la probabilidad de que un estudiante que respondió incorrectamente la pregunta 5, 
# se haya sacado un 3 en el quiz: quiero estimar P(X=3|Y=0)
# P(X=3|Y=0) = P(X=3,Y=0)/P(Y=0)
pXY

pXY[1,2]/sum(pXY[1,])

# ... P(X=3) 
sum(pXY[,2])

# ... P(X=8|Y=0)
pXY[1,7]/sum(pXY[1,])

# ... P(X=8)
sum(pXY[,7])

# 6) Estimar la probabilidad de sacarse más 6: quiero estimar P(X>6)
length(datos[Nota>6,1])/n

# la probabilidad de que teniendo nota superior a 8, la pregunta 5 haya sido correctamente respondida:
# quiero estimar P(Y=1|X>8) = P(Y=1,X>8)/P(Y>8)
sum(pXY[2,8:9])/sum(pXY[1:2,8:9])


############################
# BOXPLOTS PARALELOS E4 P6 #
############################
rm(list=ls())
# Xj: población (cientos de miles) de las 10 ciudades más pobladas en 1967 del país j

datos <- read.table("ciudades.txt", header=TRUE)

# a) Boxplot por país y outliers
attach(datos)

boxplot(Argentina)
boxplot(EEUU)
boxplot(Holanda)
boxplot(Japon)

#b) Comparar los centros de cada población, sus dispersiones y su simetría.
# ¿Cuál es más homogéneo? Los boxplot paralelos ayudan a ver características comunes y no comunes.
boxplot(Argentina, EEUU, Holanda, Japon, col=c(2,3,4,5), names = c("Arg","EEUU","Hol","Jap"))
summary(datos)


#############################
# LEY DE MOORE: SÍMIL E9 P6 #
#############################
rm(list=ls())
datos <- read.csv("moore.csv", sep=";")
attach(datos)

mean(transistors)

# Aplico una transformación a y
datos$transistors <- log10(datos$transistors)
datos
attach(datos)

# Plot bivariado: año vs log10 transistores
plot(year, transistors)

# Correlación: fuerte asociación lineal entre año y log10 transistores
cor(year, transistors)

# Modelo lineal
modelo <- lm(transistors ~ year)
modelo

alpha <- modelo$coefficients[1]
beta <- modelo$coefficients[2]

# Gráfico y modelo lineal
plot(year, transistors)
abline(alpha,beta, col="red")

10^(alpha+beta*2021)

# Mismas cuentas, pero a mano
beta <- sum((year-mean(year))*(transistors-mean(transistors)))/sum((year-mean(year))^2)
alpha <- mean(transistors)-beta*mean(year)

alpha
beta
from libs.binomial import Binomial

x = Binomial(2,1/2)
y = Binomial(2,1/3)

print (x.pk(0))
print (y.pk(1))

print (x.pk(0)*y.pk(1))
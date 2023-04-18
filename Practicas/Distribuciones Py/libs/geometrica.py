from .mathh import combinatorio, fx_acumulada

class Geometrica():
    def __init__(self,probabilidad_evento):
        self.p = probabilidad_evento
    
    def pk(self, k:int) -> float:
        # Probabilidad sean necesarios k intentos hasta el primer exito
        return ((1-self.p)**(k-1))*(self.p**k)
    
    def fx(self, k) -> float:
        return fx_acumulada(self.pk, k)

    def E(self) -> float:
        return 1/self.p
    
    def Var(self) -> float:
        return (1-self.p)/(self.p**2)
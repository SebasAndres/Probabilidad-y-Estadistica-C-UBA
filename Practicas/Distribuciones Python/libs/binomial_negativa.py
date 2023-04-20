from .mathh import combinatorio, fx_acumulada

class BinomialNegativa():
    def __init__(self, n_exitos, probabilidad_evento):
        self.r = n_exitos
        self.p = probabilidad_evento
    
    def pk(self, k:int) -> float:
        # probabilidad de que hayan r exitos en k ensayos de probabilidad p
        return combinatorio(k-1, self.r-1)*(self.p**self.r)*((1-self.p)**(k-self.r))
    
    def fx(self, k) -> float:
        return fx_acumulada(self.pk, k)

    def E(self) -> float:
        return self.r/self.p
    
    def Var(self) -> float:
        return self.r*(1-self.p)/(self.p**2)
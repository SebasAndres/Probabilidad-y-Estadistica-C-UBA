from .mathh import combinatorio, fx_acumulada

class Binomial():
    def __init__(self, n_ensayos, probabilidad_evento):
        self.n = n_ensayos
        self.p = probabilidad_evento
    
    def pk(self, k:int) -> float:
        # probabilidad de que hayan k exitos en n ensayos de probabilidad p
        return combinatorio(self.n, k) * (self.p**(self.k)) * ((1-self.p)**(self.n-k))
    
    def fx(self, k) -> float:
        return fx_acumulada(self.pk, k)

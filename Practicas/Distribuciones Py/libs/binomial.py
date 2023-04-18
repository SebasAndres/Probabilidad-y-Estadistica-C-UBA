from .mathh import combinatorio

class Binomial():
    
    def __init__(self, n_ensayos, probabilidad_evento):
        self.n = n_ensayos
        self.p = probabilidad_evento
    
    def pk(k:int) -> int:
        return combinatorio(self.n,k)
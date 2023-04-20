from .mathh import combinatorio, fx_acumulada

class Hipergeometrica():
    def __init__(self, length_total, cantidad_exitos, length_muestra):
        self.N = length_total
        self.D = cantidad_exitos
        self.n = length_muestra
    
    def pk(self, k:int) -> float:
        """
        Probabilidad de que hayan k elementos exitosos (0 <= k <= D) en una muestra de n elementos (0 <= n < N) extraidos de 
        una muestra total de N elementos con probabilidad p.
        """    
        return (combinatorio(self.D,k)*combinatorio(self.N-self.D, self.n-k))/combinatorio(self.N, self.n)

    def fx(self, k) -> float:
        return fx_acumulada(self.pk, k)

    def E(self) -> float:
        return self.n*(self.D/self.N)
    
    def Var(self) -> float:
        return
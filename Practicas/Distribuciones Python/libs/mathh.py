def factorial(n:int) -> int:
    if n == 0:
        return 1
    else:
        return n * factorial(n-1)

def combinatorio(n:int, k:int) -> int:
    return factorial(n) / (factorial(k) * factorial(n-k))

def fx_acumulada(pk, k:int) -> float:
    return [ pk(x) for x in range(0, k+1) ]
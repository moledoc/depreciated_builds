import numpy as np 
from scipy import stats #needed for Phi
Phi=stats.norm.cdf #the cumulative distribution function of the standard normal distribution
#Define Put and Call funcitons

# BS formulas for European Put and Call options.
# Assumes constant volatility.
def Call(S,E,T,r,sigma,D):
    d1=(np.log(S/E)+(r-D+sigma**2/2)*T)/(sigma*np.sqrt(T))
    d2=d1-sigma*np.sqrt(T)
    answer=S*np.exp(-D*T)*Phi(d1)-E*np.exp(-r*T)*Phi(d2)
    return(answer)
        
def Put(S,E,T,r,sigma,D):
    d1=(np.log(S/E)+(r-D+sigma**2/2)*T)/(sigma*np.sqrt(T))
    d2=d1-sigma*np.sqrt(T)
    answer=-S*np.exp(-D*T)*Phi(-d1)+E*np.exp(-r*T)*Phi(-d2)
    return(answer)
import numpy as np
from scipy import linalg

def lab5solver(theta,E,S0,T,r):
    """theta - market parameters
    E - strike price
    S0 - current stock price
    T - exercise time
    r - risk free interest rate"""
    m=2*50
    n=2*240
    xmin=0
    xmax=3*S0
    dx=(xmax-xmin)/n
    dt=T/m
    x=np.linspace(xmin,xmax,n+1)
    tau=np.linspace(0,T,m+1)
    U=np.maximum(x-E,0)
    diagonals=np.zeros(shape=(3,n-1))
    gamma=-r
    D=0
    def alpha(x,tau,theta=theta):
       return ((theta[0]+theta[1]*(1+0.1*(x-44)**2))*x)**2/2
    for k in range(1,m+1):
        a=-alpha(x[1:n],tau[k])*dt/dx**2/2+(r-D)*x[1:n]*dt/(4*dx)
        b=1+alpha(x[1:n],tau[k])*dt/dx**2-gamma*dt/2
        c=-alpha(x[1:n],tau[k])*dt/dx**2/2-(r-D)*x[1:n]*dt/(4*dx)
        e=1-alpha(x[1:n],tau[k])*dt/dx**2+gamma*dt/2
        F=-a*U[:-2]+e*U[1:-1]-c*U[2:]
        U[0]=0
        U[n]=np.exp(-D*tau[k])*xmax-np.exp(-r*tau[k])*E
        diagonals[0,1:]=c[:-1]
        diagonals[1]=b
        diagonals[2,:-1]=a[1:]
        F[0]=F[0]-a[0]*U[0]
        F[n-2]=F[n-2]-c[n-2]*U[n]
        U[1:n]=linalg.solve_banded((1,1),diagonals,F)
    return abs(U[np.int64(n/3)])


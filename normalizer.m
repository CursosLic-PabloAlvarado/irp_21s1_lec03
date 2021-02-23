#!/usr/bin/octave-cli --persist

## (C) 2020 Pablo Alvarado
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## --------------------------------------------------------------------
## Normalization object
## --------------------------------------------------------------------

## Normalize each column of the given matrix, according to the
## specified normalization method:
## "minmax": min value is mapped to -1 and max value is mapped to +1
## "normal": mean is mapped to 0 and the stddev to 1
##
## If a column of the matrix has no variance at all, it will be kept
## untouched.
classdef normalizer < handle
  properties
    ## Bias 
    bias = [];
    ## Slope
    slope = [];
    ## Normalization method in use
    method = "minmax";
  endproperties
  
  methods
    ## Constructor specifies the method
    function s=normalizer(meth="minmax")
      s.method=meth;
    endfunction

    ## Compute the normalization factors
    ## If a column has zero varianced, it is kept unchanged
    function fit(s,X)
      if (s.method=="minmax")
        mn=min(X);
        mx=max(X);
        dx=mx-mn;
        dy=2;
        dxx = (dx==0).*dy + dx;
        s.slope = dy./dxx;
        s.bias = (1 - s.slope .* mx).*(dx!=0);
      elseif (s.method=="normal")
        mn=mean(X);
        sd=std(X);

        stf = (sd==0) + sd;   ## avoid division by 0
        s.slope = 1./stf;
        s.bias = (-s.slope .* mn) .* (sd!=0);
      else
        error("Unknown normalization method");
      endif
    endfunction

    ## Transform the given data with the last computed
    ## factors
    function Xn=transform(s,X)
      Xn = s.slope.*X + s.bias;
    endfunction
    
    ## Compute the factors and transform the data
    function Xn=fit_transform(s,X)
      s.fit(X);
      Xn=s.transform(X);
    endfunction

    ## Inverse mapping: denormalize 
    function X=itransform(s,Xn)
      X = (Xn - s.bias) ./ s.slope;
    endfunction
    
  endmethods
endclassdef

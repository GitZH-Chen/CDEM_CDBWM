function interpolations = geodesic_BWM(P, Q, num)
    
    sqrt_PQ = sqrt_of_product_spd(P,Q);
    X=sqrt_PQ+sqrt_PQ'- 2*P;
        
    nterpolations = cell(1, num);
    for i = 1:num
        t = (i-1)/(num-1);
        direction = t*X;
        L_P_direction = lyapunov_sym(P,direction);
        interpolations{i} = P + direction + L_P_direction * P * L_P_direction;
    end 
end



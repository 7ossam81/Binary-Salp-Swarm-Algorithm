function [posOut]=trnasferFun(pos,temp,ID)
if ID==1
    s=1/(1+exp(-2*temp)); %S1 transfer function
end
if ID==2
    s=1/(1+exp(-temp));   %S2 transfer function
end
if ID==3
    s=1/(1+exp(-temp/2)); %S3 transfer function
end
if ID==4
    s=1/(1+exp(-temp/3));  %S4 transfer function
end

% if ID==5
%     s=abs(erf(((sqrt(pi)/2)*temp))); %V1 transfer function
% end
% if ID==6
%     s=abs(tanh(temp)); %V2 transfer function
% end
% if ID==7
%     s=abs(temp/sqrt((1+temp^2))); %V3 transfer function
% end
% if ID==8    %  we use this one  8
%     s=abs((2/pi)*atan((pi/2)*temp)); %V4 transfer function
% end
% 
% if ID<=4 %S-shaped transfer functions
%     if rand<s % Equation (4) and (8)
%         posOut=1;
%     else
%         posOut=0;
%     end
% end

% if ID>4 && ID<=8 %V-shaped transfer functions
%     if rand<s %Equation (10)
%         posOut=~pos;
%     else
%         posOut=pos;
%     end
% end
if ID==5
    if (temp<=0)
        s=1-(2/(1+exp(-2*temp))); %V1 transfer function
    else
        s=(2/(1+exp(-2*temp)))-1;
    end
end
if ID==6
    if (temp<=0)
        s=1-(2/(1+exp(-temp))); %V1 transfer function
    else
        s=(2/(1+exp(-temp)))-1;
    end
end
if ID==7
    if (temp<=0)
        s=1-(2/(1+exp(-temp/2))); %V1 transfer function
    else
        s=(2/(1+exp(-temp/2)))-1;
    end
end
if ID==8
    if (temp<=0)
        s=1-(2/(1+exp(-temp/3))); %V1 transfer function
    else
        s=(2/(1+exp(-temp/3)))-1;
    end
end


if ID<=4 %S-shaped transfer functions
    if rand<s % Equation (4) and (8)
        posOut=1;
    else
        posOut=0;
    end
end

if ID>4 && ID<=8 %V-shaped transfer functions
    if rand<=s && temp <= 0% Equation (4) and (8)
        posOut=0;
    elseif rand<=s && temp > 0% Equation (4) and (8)
        posOut=1;
    else 
        posOut=pos;
    end
    
end

end

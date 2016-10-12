function[maxviol]=maxviolation(A,x,b)
[m,n]=size(A);
maxviol=-inf;
for i=1:m;
    if A(i,:)*x-b(i)>maxviol
        maxviol=A(i,:)*x-b(i);
    end
end


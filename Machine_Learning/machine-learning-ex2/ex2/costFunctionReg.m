function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));
size_theta=size(theta);
% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

h_theta_x=1./(1+exp(-X*theta));
J=-1/m*(y'*log(h_theta_x)+(ones(m,1)-y)'*log(ones(m,1)-h_theta_x))+lambda/m/2*(theta(2:size_theta)'*theta(2:size_theta));

grad=1/m*X'*(h_theta_x-y)+lambda/m*theta;
grad(1)=1/m*X(:,1)'*(h_theta_x-y);

% =============================================================

end

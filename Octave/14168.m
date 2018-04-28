tr_path = input("Input path to train file ", "s");
te_path = input("Input path to test file ", "s");

%tr_path ='/home/ayushya/Downloads/Assignment-3/train.csv';
%te_path ='/home/ayushya/Downloads/Assignment-3/test.csv';


trf = csvread(tr_path);
tef = csvread(te_path);
ntrain = size(trf,1);
ntest = size(tef,1);


X_train = trf(1:ntrain,1);
Y_train = trf(1:ntrain,2);
X_train = [ones(ntrain,1) X_train];

w = rand(2,1);
y_p = X_train*w;
figure(1)
scatter(X_train(:,2),Y_train);
hold on
plot(X_train(:,2),y_p,'r');
legend({"train data","predicted data"});
w_dir = inv(X_train'*X_train)*X_train'*Y_train;

y_p2 = X_train*w_dir;
figure(2)
scatter(X_train(:,2),Y_train);
hold on
plot(X_train(:,2),y_p2,'r');
hh = legend({"train data","predicted data"});

N = 1;
eta = 0.00000001;
for i=1:N
  for j = 1:ntrain
      x_prime = X_train(j,:)';
      w = w - eta*(w'*x_prime - Y_train(j))*x_prime;
      
      if mod(j,1000) == 0
        
        y_p = X_train*w;
        figure(3)
        scatter(X_train(:,2),Y_train);
        hold on
        plot(X_train(:,2),y_p,'r');
        hh = legend({"train data","predicted data"});

        
      end
      
  end
end

y_p = X_train*w;

figure(4)
scatter(X_train(:,2),Y_train);
hold on
plot(X_train(:,2),y_p,'r');
hh = legend({"train data","predicted data"});



X_test = tef(1:ntest,1);
Y_test = tef(1:ntest,2);
X_test = [ones(ntest,1) X_test];

y_pred1 = X_test*w;
y_pred2 = X_test*w_dir;
rmse1 = norm(y_pred1 - Y_test, 2)/sqrt(ntest);
rmse2 = norm(y_pred2 - Y_test, 2)/sqrt(ntest);
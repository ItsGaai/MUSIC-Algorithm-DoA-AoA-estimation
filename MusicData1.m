clear all
close all
clc
derad = pi/180; % �Ƕ�->����
radeg = 180/pi; % ����->�Ƕ�
twpi = 2*pi;
kelm = 8;       % ��Ԫ����   
dd = 0.5;       % ��Ԫ���   
d=0:dd:(kelm-1)*dd;
iwave = 3;      % ��Դ��
theta = -60:0.5:60;  % MUSIC�׷������ķ�Χ
snr = 10;            % �����
n = 512;             % ���������߳�Ϊ������
A=exp(-1i*twpi*d.'*sin(theta*derad)); % ����ʸ��,��������,.'ת�ã�'����ת��
iq = dlmread('data1.txt',',',1,0); 
S = 1i*iq(1:2:end) + iq(2:2:end);     % ���������鲿ʵ����
X = reshape(S,kelm,n); 
% X1 = awgn(X,snr,'measured');% ���������ǰ�����ź�X�Ĺ���(dBW)
X1 = awgn(X,snr,'measured');
Rxx = X1*X1'/n;
InvS = inv(Rxx);
[EV,D] = eig(Rxx);            % ����ֵ�ֽ�
EVA = diag(D)';               % ������ֵ����Խ�����ȡ��תΪһ��
[EVA,I] = sort(EVA);          % ������ֵ���򣬴�С����
EVA = fliplr(EVA);
EV = fliplr(EV(:,I));         % ��Ӧ����ʸ������

% ����ÿ���Ƕȣ�����ռ���
for iang = 1:361
    angle(iang) = (iang-181)/2;    % ��λ��
    phim = derad*angle(iang);
    a = exp(-1i*twpi*d*sin(phim)).';  
    L = iwave;
    En=EV(:,L+1:kelm);             % �õ������ӿռ�
    SP(iang) = (a'*a)/(a'*En*En'*a);
end 

% ��ͼ
SP = abs(SP);
SPmax = max(SP);             % �����ֵ����
SP = 10*log10(SP/SPmax);     % ��һ������
h = plot(angle,SP);
set(h,'Linewidth',2)
xlabel('�����angle (degree)')
ylabel('�ռ���magnitude (dB)')
axis([-90 90 -60 0])
set(gca, 'XTick',(-90:10:90))
grid on     
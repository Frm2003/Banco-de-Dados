create database aula02
go
use aula02

--a) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
declare @num int
set @num = 1

if (@num % 2 = 0) begin print('é multiplo de 2') end
else begin print('não é multiplo de 2') end

if (@num % 3 = 0) begin print('é multiplo de 3') end
else begin print('não é multiplo de 3') end

if (@num % 5 = 0) begin print('é multiplo de 5') end
else begin print('não é multiplo de 5') end

--b)  Fazer um algoritmo que leia 3 números e mostre o maior e o menor
declare @n1 int, @n2 int, @n3 int, @maior int, @menor int
set @n1 = 3 
set @n2 = 5 
set @n3 = 10

if (@n1 < @n2) begin 
	if (@n1 < @n3) begin 
		set @menor = @n1
	end
	else begin
		set @menor = @n3
	end
end
else begin 
	if (@n2 < @n3) begin 
		set @menor = @n2
	end
	else begin
		set @menor = @n3
	end
end

if (@n1 > @n2) begin 
	if (@n1 > @n3) begin 
		set @maior = @n1
	end
	else begin
		set @maior = @n3
	end
end
else begin 
	if (@n2 > @n3) begin 
		set @maior = @n2
	end
	else begin
		set @maior = @n3
	end
end
print('Maior: ' + cast(@maior as varchar(10)) + ' | ' + 'Menor: ' + cast(@menor as varchar(10)))

--c) Fazer um algoritmo que calcule e exiba os 15 primeiros termos da série 1,1,2,3,5,8,13,21,... E, posteriormente, calcule e exiba a soma dos 15 termos
declare @soma int, @f int, @ant int, @i int
set @soma = 0
set @f = 0
set @ant = 1
set @i = 0

while (@i < 15) begin
	set @f = @f + @ant
	set @ant = @f - @ant
	set @i = @i + 1
	set @soma = @soma + @f
	print(@f)
end

print('Soma: ' + cast(@soma as varchar(10)))

--d) Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em minúsculo 
--(Usar funções UPPER e LOWER). Deve exibir o resultado ao final.
declare @frase varchar(100) = 'Lorem ipsum dolor sit amet'

select value from STRING_SPLIT(lower(@frase), ' ')
select value from STRING_SPLIT(upper(@frase), ' ')


--e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING). Deve exibir o resultado ao final.
declare @palavra varchar(10) = 'ame a ema'
declare @cont int = len(@palavra)
declare @i int = 0
declare @palavraInversa varchar(10) = ''

-- 5 - 1
while (@cont != 0) begin
	set @palavraInversa = @palavraInversa + SUBSTRING(@palavra, @cont, 1)
	set @i = @i + 1
	set @cont = @cont - 1
end

print(@palavraInversa)
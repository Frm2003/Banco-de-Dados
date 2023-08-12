create database revisao00

use revisao00

create table Aluno(
	ra integer not null,
	nome varchar(100) not null,
	idade integer not null,

	primary key(ra)
)

create table Curso(
	codigo integer not null,
	nome varchar(50) not null,
	area varchar(100) not null,

	primary key(codigo)
)

create table Disciplina(
	codigo integer not null,
	nome varchar(80) not null,
	cargaHoraria integer not null,

	primary key(codigo)
)

create table Titulacao(
	codigo integer not null,
	titulo varchar(40) not null,

	primary key(codigo)
)

create table Professor(
	registro integer not null,
	nome varchar(100) not null,
	titulacao integer,
	foreign key (titulacao) references Titulacao(codigo),

	primary key (registro) 
)

-- RELAÇÕES
create table DisciplinaProfessor(
	codigo integer not null,
	foreign key (codigo) references Disciplina(codigo),
	registro integer not null
	foreign key (registro) references Professor(registro),

	primary key (codigo, registro)
) 

create table CursoDisciplina(
	disciplina integer not null,
	foreign key (disciplina) references Disciplina(codigo),
	curso integer not null,
	foreign key (curso) references Curso(codigo),
	
	primary key (curso, disciplina)
)

create table AlunoDisciplina(
	disciplina integer not null,
	foreign key (disciplina) references Disciplina(codigo),
	ra integer not null,
	foreign key (ra) references Aluno(ra),

	primary key (ra, disciplina)
)

select * from Aluno
select * from Curso
select * from Disciplina
select * from Professor
select * from Titulacao

select * from AlunoDisciplina
select * from CursoDisciplina
select * from DisciplinaProfessor

-- Fazer uma pesquisa que liste o nome das disciplinas e o nome dos professores que as ministram
select d.nome, p.nome
from Disciplina d inner join DisciplinaProfessor dp on d.codigo = dp.codigo inner join Professor p on p.registro = dp.registro

-- Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o nome do curso
declare @nomeDisc varchar(80)
set @nomeDisc = 'Gestão de Estoques'

select c.nome
from Disciplina d inner join CursoDisciplina cp on d.codigo = cp.disciplina inner join Curso c on cp.curso = c.codigo
where d.nome = @nomeDisc

-- Fazer uma pesquisa que , dado o nome de uma disciplina, retorne sua área								
declare @nomeDisc varchar(80)
set @nomeDisc = 'Laboratório de Banco de Dados'

select c.area
from Disciplina d inner join CursoDisciplina cp on d.codigo = cp.disciplina inner join Curso c on cp.curso = c.codigo
where d.nome = @nomeDisc

-- Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o título do professor que a ministra
declare @nomeDisc varchar(80)
set @nomeDisc = 'Laboratório de Banco de Dados'

select p.titulacao
from Disciplina d inner join DisciplinaProfessor dp on d.codigo = dp.codigo inner join Professor p on dp.registro = p.registro
where d.nome = @nomeDisc

-- Fazer uma pesquisa que retorne o nome da disciplina e quantos alunos estão matriculados em cada uma delas
select d.nome, count(a.ra)
from Disciplina d inner join AlunoDisciplina ad on d.codigo = ad.disciplina inner join Aluno a on ad.ra = a.ra
group by d.nome

select disciplina, count(ra) from AlunoDisciplina group by disciplina

select * from Disciplina

-- Fazer uma pesquisa que, dado o nome de uma disciplina, retorne o nome do professor.  Só deve retornar de disciplinas que tenham, no mínimo, 5 alunos matriculados
declare @nomeDisc varchar(80)
set @nomeDisc = 'Teste de Software'
select p.nome as momeProfessor, d.nome as nomeDisciplina, count(a.ra) as alunosMatriculados
from Disciplina d inner join DisciplinaProfessor dp on d.codigo = dp.codigo 
		inner join Professor p on p.registro = dp.registro 
		inner join AlunoDisciplina ad on d.codigo = ad.disciplina 
		inner join Aluno a on ad.ra = a.ra
where d.nome = @nomeDisc
group by p.nome, d.nome having count(a.ra) >= 5
-- Fazer uma pesquisa que retorne o nome do curso e a quatidade de professores cadastrados que ministram aula nele. A coluna de ve se chamar quantidade
select c.nome as nomeCurso, count(p.registro) as quantidade
from Curso c inner join CursoDisciplina cd on c.codigo = cd.curso
		inner join Disciplina d on cd.disciplina = d.codigo
		inner join DisciplinaProfessor dp on d.codigo = dp.codigo
		inner join Professor p on dp.registro = p.registro
group by c.nome

select * from Curso
select * from Professor
select * from DisciplinaProfessor
select * from CursoDisciplina
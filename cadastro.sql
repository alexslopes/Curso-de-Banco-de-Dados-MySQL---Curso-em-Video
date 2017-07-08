/*Create: (DDL)Comando de definição de dados->Data definition language*/
create database cadastro /*inicio constraints*/
default character set utf8 
default collate utf8_general_ci; /*definição dos caracteres*/

create table pessoas (
	id int not null auto_increment,/*auto_increment incrementa o int de um em um*/
	nome varchar(30) not null, /*null -> constraint: regras para definião de dados, obrigado a digitar*/
    nascimento date,
    sexo enum('M','F'),/*enum permite definir quais caracteres são permitidos colcolocar*/
    peso decimal(5,2),/*formato: (total de casas,quantidade de numeros após a vírgula)*/
    altura decimal(3,2),
    nacionalidade varchar(20) DEFAULT 'Brasil', /*default -> é uma 'constraint',Define o padrão caso nada seja digitado como Brasil*/
    primary key(id) /*Definição de chave primaria*/
) default charset = utf8;/*configuração de caractere padrão para a tabela*/

/*colocar crase entre nome dos campos permite
utiliza acento e espaços neles. ex: *`data de nascimento` date*,
mas não é recomendado*/ 

/*Aula 5*/
/*Insert -> DML: data manipulation language*/
/*valores são colocador entre crases*/
/*Não foi inserido o id, pq é auto incrementado*/
insert into pessoas(nome, nascimento, sexo, peso, altura, nacionalidade)
values('Godofredo','1984-01-02','M','78.5','1.83','Brasil');

insert into pessoas(nome, nascimento, sexo, peso, altura, nacionalidade)
values('Maria','1999-12-30','F','55.2','1.65','Portugal');

insert into pessoas(id, nome, nascimento, sexo, peso, altura, nacionalidade)
values(DEFAULT, 'Creuza','1928-12-30','F','50.2','1.65',DEFAULT);

insert into pessoas
values(DEFAULT, 'Adalgiza','1930-11-2','F','53.2','1.75','Irlanda');

insert into pessoas values
(DEFAULT, 'Claudio','1975-4-22','M','99.0','2.15','Brasil'),
(default,'Pedro','1999-12-3','M','87','2',default),
(default,'Janaína','1987-11-12','F','75.4','1.66','EUA');

/*Aula 6*/
alter table pessoas
add column profissao varchar(10);/*adciona coluna*/

alter table pessoas
drop column profissao;/*exclui coluna*/

alter table pessoas
add column profissao varchar(10) after nome;/*Adciona coluna depois de uma coluna*/

alter table pessoas
add  codigo int first;/*adciona como primeira coluna da tabela*/
/*Obs: o comando column em alter table é opcional*/

alter table pessoas
modify column profissao varchar(20) not null default ' ';/*modifica o tipo primitivo e as constraint, mas não é possível renomear*/
/*para adcionar uma constraint not null foi preciso definir como default um campo vazio*/

alter table pessoas
change column profissao prof varchar(20);/*renomeia a coluna, mas é necessário colocar os tipos e suas constraints*/

alter table pessoas
rename to gafanhotos;/*renomeia tabela*/

create table if not exists  cursos(/*if not exists: cria tabela caso não exista, evita sobreescrever os dados na rexistente*/
	nome varchar(30) not null unique,/*unique: evita que existam nomes repetidos em colunas*/
    descricao text,
    carga int unsigned,/*unsigned: não permite valores negativos*/
    totaulas int unsigned,
    ano year default '2016'
)default charset=utf8;

alter table cursos
add primary key(idcurso);/*adciona chave primaria*, necesário criar a coluna primeiro para depois criar a chave primaria*/

alter table gafahnotos
drop column codigo;

create table if not exists test (test int);

drop table if exists test;/*apaga tabela*/


/*Aula 7*/
/*comandos UPDATE(dml), delete(dml) e truncate(dml)*/
insert into cursos values
('1','HTML4','Curso de HTML5','40','37','2014'),
('2','Algoritmos','Lógica de Programação','20','15','2014'),
('3','Photoshop','Dica de Photoshop CC','10','8','2014'),
('4','PGP','Curso de PHP para inicantes','40','20','2010'),
('5','Jarva','Introdução à Linguagem Java','10','29','2000'),
('6','MySQL','Banco de Dados MyQL','30','15','2016'),
('7','Word','Curso completo de Word','40','30','2016'),
('8','Sapateado','Danças Rítimicas','40','30','2015'),
('9','Cozinha Árabe','Aprenda a fazer Kibe','40','30','2018'),
('10','Youtube','Gerar polêmica e ganhar inscritos','5','2','2018');

update cursos
set nome = 'HTML5' 
WHERE idcurso = '1';/*Altera nome de um registo na tupla*/

update cursos
set nome = 'PHP', ano = '2015'/*<---É possível alterar mais de uma coluna em uma tupla*/
where idcurso = '4';

update cursos
set nome = 'Java', carga = '40', ano = '2015'
where idcurso = '5'
limit 1;/*Limita a mudança do registro para x tupla(s)*/

update cursos/*ATENÇÃO, EVITE USAR UPDATE*/
set ano = '2050', carga = '800'/*USE APENAS QD MUITO NECESSÁRIO*/
where ano = '2018';/*NUNCA EXECUTE UM UPDATE SEM LIMIT*/

update cursos/*ATENÇÃO*/
set ano = '2018', carga = '0'
where ano = '2050'
limit 1;/*NUNCA EXECUTE UM UPDATE SEM LIMIT*/

delete from cursos
where idcurso = '8';/*Apaga tupla que estiver com identificador x*/

delete from cursos
where ano = '2018'
limit 3;/*Também é possível limitar a quantidade de registros a serem exculído*/

truncate table cursos;/*Apaga TODOS  os registros*/
/*ou*/
truncate cursos;/*Apaga TODOS  os registros*/

/*Aula 8*/
drop database cadastro;

/*_________________________
Campo de seleção*/
select * from cursos order by idcurso;
select * from pessoas;/*TRADUÇÂO: selecione *(tudo) de pessoas*/
desc cursos;
/*ou*/
describe gafahnotos;

alter table cursos
modify column idcurso int default '0' ;

/*__Aula 11, select____*/
select * from gafanhotos;

select * from cursos
order by nome desc;/*ordem decrescente*/

select nome, carga, ano from cursos
order by nome;

select ano, nome, carga from cursos
order by ano,nome;/*primeiro ordena por ano, depois por nome*/

select * from cursos
where ano = '2016'/*so seleciona onde o ano é 2016*/
order by nome;

select nome, descricao, carga from cursos
where ano < 2015
order by ano, nome;

select nome, ano from cursos
where ano BETWEEN '2014' and '2016'/*seleciona ENTRE 2014 e 2016*/
order by ano desc, nome;

select nome, descricao, ano from cursos
where ano in (2014, 2016)/*Mostra somente cursos de 2014 e 2016*/
order by ano;

select nome, carga, totaulas from cursos
where carga > 35 or totaulas < 30
order by nome;

/*---Aula 12-------*/
select * from cursos
where nome like 'p%';/*procura cursos que comecem com P*/

select * from cursos
where nome like '%a';/*procura cursos que terminem com A*/

select * from cursos
where nome like '%a%';/*procura cursos que tenham  A em qualquer lugar*/

select * from cursos
where nome not like '%a%';/*procura cursos que não possuam A em lugar algum*/

update cursos set nome = 'PáOO' where idcurso = '9';

select * from cursos
where nome like 'ph%p';/*seleciona cursos que comecem com ph e terminem com p*/

select * from cursos
where nome like 'ph%p%';/*seleciona nomes que tenham ph e p em seus nomes*/

select * from cursos
where nome like 'ph%p_';/*seleciona nomes que tenham ph e p e um caractere no final*/

select * from cursos
where nome like 'p__t%';/*seleciona nomes que tenham p duas quaisquer letras '__' seguidas por um t*/

select distinct nacionalidade from gafanhotos;/*Mostra as ocorrencias sem repetilas, ou seja as distingue*/

select count(*) from cursos;/*Conta a quantidade de registros cadastrados*/

select count(*) from cursos
where carga > 40;/*Conta a quantidade de registros cadastrados que tenham carga menor que 40*/

select max(carga) from cursos;/*retorna a maior carga entre os cursos*/

select max(totaulas) from cursos where ano = '2016';/*retorna o curso que teve maior total de aulas em 2016*/

select nome,min(totaulas) from cursos where ano = '2016';/*retorna o curso que teve menor total de aulas em 2016. 
Obs: ele retorna apenas a primeira ocorrencia*/

select sum(totaulas) from cursos where ano = '2016';/*retorna a soma de total de aulas de 2016*/

select avg(totaulas) from cursos where ano = '2016';/*retorna a média de total de aulas do curso de 2016*/

/*---Exercícios---
1) Uma lista com o nome de toads as gafanhotas;*/
select nome from gafanhotos
where sexo = 'F';

/*2)lista com os dados de todos aqueles que nasceram entre 1/jan/2000 e 31/DEZ/2015*/
select * from gafanhotos
where nascimento between '2000-01-01' and '2015-12-31';

/*3)Uma lista de todos os homens que trabalham como programadores*/
select * from gafanhotos
where sexo = 'M' and profissao = 'programador';

/*4)Lista de todas as mulheres que nasceram no Brasil e tem o nome iniciado com J*/
select * from gafanhotos
where sexo = 'F' and
nome like 'j%';

/*5)Lista com a nacionalidade de todos os homens que tem Silva no nome, não nasceram no Brasil
e pesam menos de 100kg*/
select * from gafanhotos
where sexo = 'M' and
nome like '%_Silva%' and
nacionalidade != 'Brasil' and
peso<'100';

/*6)Qual a maior altura entre gafanhotos homens que moram no brasil?*/
select nome,max(altura) from gafanhotos
where nacionalidade = 'Brasil';

/*7)Qual a média de peso dos gafanhotos cadastrados?*/
select avg(peso) from gafanhotos;

/*8)Qual o menor peso entre os gafanhotos mulheres que nasceram fora do Brasil entre
1/Jan/1990 e 31/DEZ/2000?*/
select nome, min(peso) from gafanhotos
where sexo = 'f' and
nacionalidade != 'Brasil' and
nascimento between '1990-01-1' and '2000-12-31';

/*9)Quantas  gafanhotos mulheres tem mais de 1.9 de altura?*/
select count(nome) from gafanhotos
where sexo = 'F' and
altura > '1.9';

/*________Aula 13____*/
select count(nome),nacionalidade from gafanhotos
group by (nacionalidade);/*Agrupa o campo selecionado*/

select carga, count(nome) from cursos
group by carga
order by carga;

select carga, count(nome) as nome from cursos where totaulas = 30
group by carga;

select ano, count(*) from cursos
group by ano
having count(ano) >= 5/*havinng utilizado com group by, ou campos que estejam juntos*/
order by count(*) desc;

select avg(carga) from cursos;

select ano, count(*) from cursos
where totaulas > 30
group by ano
having ano > 2013
order by count(*) desc;

select carga, count(*) from cursos
where ano > 2015
group by carga;

select carga, count(*) from cursos
where ano > 2015
group by carga
having carga > (select avg(carga) from cursos);

select * from cursos where totaulas = 30;

/*--Exercicio--*/
select profissao, count(*) from gafanhotos
group by profissao;

select sexo, count(*) from gafanhotos
where nascimento > '2005-01-1'
group by sexo;

select  nacionalidade, count(*) from gafanhotos
group by nacionalidade
having count(*) >3 and nacionalidade != 'Brasil';

select peso, count(*) from gafanhotos where peso > '100' group by altura having altura > (select avg(altura) from gafanhotos);

/*_________Aula 15____________*/
use cadastro;
describe gafanhotos;

alter table gafanhotos add column cursopreferido int ;

alter table gafanhotos 
add foreign key(cursopreferido)
references cursos(idcurso);

select * from gafanhotos;

update gafanhotos set cursopreferido = '6' where id ='1';

delete from cursos where idcursos = '6';

delete from cursos where idcurso = '28';

select g.nome, g.cursopreferido, c.nome, c.ano 
from gafanhotos as g join cursos as c/*Clausula 'join'/'inner join' junta as tabelas que possuem relação*/
on c.idcurso = g.cursopreferido;/*clausula 'on' filtra o resultado da tabela pela condição estabelecida*/

select g.nome, g.cursopreferido, c.nome, c.ano 
from gafanhotos as g left outer join cursos as c /*left outer join exibe todos registro da tabela da esquerda memos as que nn tem relação com a direita*/
on c.idcurso = g.cursopreferido;

/*_____Aula 16___*/

create table gafanhoto_assiste_curso(
	id int NOT NULL AUTO_INCREMENT,
    data date,
    idgafanhoto int,
    idcurso int,
    primary key(id),
    foreign key(idgafanhoto) references gafanhotos(id),
    foreign key(idcurso) references cursos(idcurso)
)default charset = utf8;

insert into gafanhoto_assiste_curso values
(default, '2014-03-01', '1', '1');

select * from gafanhoto_assiste_curso;

select g.nome, c.nome from gafanhotos g
join gafanhoto_assiste_curso a
on g.id = a.idgafanhoto
join cursos c
on c.idcurso = a.idcurso;
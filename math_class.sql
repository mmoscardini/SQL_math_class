drop database if exists mat_geometria_2018;
create database mat_geometria_2018;
use mat_geometria_2018;

create table materia (
    codigo int primary key auto_increment not null,
    nome varchar(30),
    descrição text
);

create table alunos (
    id int primary key auto_increment not null,
    nome varchar(50),
    idade int,
    genero char(1)
);

create table projetos(
    id int primary key auto_increment not null,
    titulo varchar (100),
    grupo int,
    nota float
);

create table grupos (
    id int primary key auto_increment not null,
    aluno_1 int,
    aluno_2 int,
    aluno_3 int,
    aluno_4 int,
    aluno_5 int
);

insert into materia (nome, descrição)
value ('Matematica - Geometria', 'Matéria oferecida pelo departamento de matemática pura para alunos do primeiro colegial');

insert into alunos (nome, idade, genero) 
value ('Matheus', 13, 'H');
insert into alunos (nome, idade, genero) 
value ('Ana', 12, 'M');
insert into alunos (nome, idade, genero) 
value ('Ricardo', 13, 'H');
insert into alunos (nome, idade, genero) 
value ('Denise', 13, 'M');
insert into alunos (nome, idade, genero) 
value ('Maria', 12, 'M');
insert into alunos (nome, idade, genero) 
value ('Jonas', 12, 'H');
insert into alunos (nome, idade, genero) 
value ('Pedro', 14, 'H');
insert into alunos (nome, idade, genero) 
value ('Francine', 13, 'M');
insert into alunos (nome, idade, genero) 
value ('Rebeca', 12, 'M');
insert into alunos (nome, idade, genero) 
value ('Evandro', 13, 'H');
insert into alunos (nome, idade, genero) 
value ('Marcela', 11, 'M');
insert into alunos (nome, idade, genero) 
value ('Andressa', 12, 'M');
insert into alunos (nome, idade, genero) 
value ('Marcela', 12, 'M');

insert into grupos (aluno_1,aluno_2,aluno_3,aluno_4)
value (1,2,3,4);
insert into grupos (aluno_1,aluno_2,aluno_3,aluno_4)
value (5,6,7,8);
insert into grupos (aluno_1,aluno_2,aluno_3,aluno_4,aluno_5)
value (9,10,11,12,13);


insert into projetos (titulo, grupo)
value ("Teorema de Piragoras", 1);
insert into projetos (titulo, grupo)
value ("Estimando pi", 2);
insert into projetos (titulo, grupo)
value ("Volume de solidos Regulares", 3);

-- Usando distinct para procurar por valores duplicados
select count(nome) as "Todos", count( distinct nome) as "Distintos" from alunos;

-- Encontrando valor duplicado
select nome, count(*) 
from alunos
group by nome
having count(*)>1;

-- Encontrando ID
select * from alunos where nome = "Marcela";

-- Alterando nomes
update alunos
set nome = "Marcela T"
where id = 11;

update alunos
set nome = "Marcela B"
where id = 13;
-- Procurando novamente por valores duplicados
select nome, count(*) 
from alunos
group by nome
having count(*)>1;

-- Order by name
select * from alunos order by nome;

-- Aggregate
-- Qual a distribuição de genero da sala? 
select sum(case when genero = "H" then 1 else 0 end) as 'Homem', sum(case when genero = "M" then 1 else 0 end) as 'Mulher' from alunos;

-- Listar os projetos e o nome de todos os seus integrantes
select projetos.titulo, 
    (select nome from alunos where grupos.aluno_1 = alunos.id) as "aluno_1",
    (select nome from alunos where grupos.aluno_2 = alunos.id) as "aluno_2",
    (select nome from alunos where grupos.aluno_3 = alunos.id) as "aluno_3",
    (select nome from alunos where grupos.aluno_4 = alunos.id) as "aluno_4",
    (select nome from alunos where grupos.aluno_5 = alunos.id) as "aluno_5"
from projetos
right join grupos
on projetos.grupo = grupos.id;  

-- Quais o aluno mais velho? e o mais novo? 
select a.nome as "mais_velho", a.idade as "idade_mais_velho", b.nome as "mais_novo", b.idade as "idade_mais_novo"
from 
    (select nome, idade
    from alunos
    order by idade desc
    limit 1) a
join
    (select nome, idade
    from alunos
    order by idade asc
    limit 1) b;

-- Definir notas
declare projeto_1 decimal;
declare projeto_2 decimal;
declare projeto_3 decimal;

projeto_1 = 8.0;
projeto_2 = 10.0;
projeto_3 = 8.5;

update projetos 
set nota = (case
                when id = 1 then @projeto_1
                when id = 2 then @projeto_2
                when id = 3 then @projeto_3
            end);

select * from projetos;

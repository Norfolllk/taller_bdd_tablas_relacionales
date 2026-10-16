create database biblioteca_db;

create table libros (
    codigo varchar(5) primary key,
    titulo varchar(50) not null,
    paginas int not null
);

select * from libros;

create table autores (
    id int primary key,
    nombre varchar(50) not null,
    pais varchar(30) not null
);

select * from autores;


-- Tabla de rompimiento (relación muchos a muchos)
create table libro_autor (
    la_libro_codigo_fk varchar(5) not null,
    la_autor_id_fk int not null,
    anio_publicacion int not null,

    primary key (la_libro_codigo_fk, la_autor_id_fk),

    constraint fk_libros foreign key (la_libro_codigo_fk) references libros(codigo),
    constraint fk_autores foreign key (la_autor_id_fk) references autores(id)
);

select * from libro_autor;


insert into libros
(codigo, titulo, paginas)
values
('L001', 'lorem 1', 10),
('L002', 'lorem 2', 11),
('L003', 'lorem 3', 12),
('L004', 'lorem 4', 13);

insert into autores
(id, nombre, pais)
values
(1, 'Juan', 'EC'),
(2, 'Pedro', 'CO'),
(3, 'Pablo', 'PA');

insert into libro_autor
(la_libro_codigo_fk, la_autor_id_fk, anio_publicacion)
values
('L001', 1, 2015),
('L001', 2, 2016),
('L002', 1, 2017),
('L003', 2, 2020),
('L004', 3, 2021);

select * from libro_autor;


-- Consultas SQL
-- Consulta 1
select
    lb.titulo,
    aut.nombre,
    aut.pais,
    la.anio_publicacion
from libros lb
inner join libro_autor la
on (
    lb.codigo = la.la_libro_codigo_fk
)
inner join autores aut
on (
    la.la_autor_id_fk = aut.id
);

-- Consulta 2
select
    lb.*,
    la.anio_publicacion
from libros lb
inner join libro_autor la
on (
    lb.codigo = la.la_libro_codigo_fk
)
where la.anio_publicacion > 2020;

-- Consulta 3
select
    *
from autores
where pais = 'CO';

-- Consulta 4
select
    lb.*,
    la.anio_publicacion
from libros lb
inner join libro_autor la
on (
    lb.codigo = la.la_libro_codigo_fk
)
order by la.anio_publicacion desc;

-- Consulta 5
select
    au.id,
    au.nombre,
    count(lb.codigo) as "cantidad_libros"
from libros lb
inner join libro_autor la
on (
    lb.codigo = la.la_libro_codigo_fk
)
inner join autores au
on (
    au.id = la.la_autor_id_fk
)
group by au.id, au.nombre
order by au.id;


-- Agregar columna precio
alter table libros
add column precio double precision;

-- Actualizar precios
update libros set
precio = 29.99
where codigo = 'L001';

update libros set
precio = 9.99
where codigo = 'L002';

update libros set
precio = 39.99
where codigo = 'L003';

-- Titulo y precio
select
    titulo,
    precio
from libros;
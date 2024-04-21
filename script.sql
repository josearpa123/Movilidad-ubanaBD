create table categotia
(
    id_categoria serial
        constraint key_id_categoria
            primary key,
    perimetro    numeric(10, 2) not null,
    profundidad  numeric(10, 2) not null,
    n°incidentes integer
);

alter table categotia
    owner to postgres;

create table baches
(
    id_baches        serial
        constraint key_id_baches
            primary key,
    categoria        integer not null
        constraint fk_categoria
            references categotia,
    ubicacion_bache  integer,
    fecha_reporte    date,
    fecha_raparacion date
);

alter table baches
    owner to postgres;

create table ubicacion_bache
(
    id_ubicacion_bache serial
        constraint key_id_ubicacion_bache
            primary key,
    ubicacion_bache    geography(Point, 4326) not null,
    id_baches          integer
        constraint foreign_key_id_bache
            references baches
);

alter table ubicacion_bache
    owner to postgres;

create table calles
(
    id_calles       serial
        constraint pk_id_caller
            primary key,
    coordenadar_geo geography(Point, 4326) not null,
    ubicacion_bache integer
        constraint fk_ubicacion_bache
            references ubicacion_bache,
    ciudad          integer                not null,
    nombre          varchar(50)            not null
);

alter table calles
    owner to postgres;

create table ubicacion_usuario
(
    id_ubicacion_usuario serial
        constraint pk_id_ubicacion_usuario
            primary key,
    id_usuario           integer                not null,
    direccion_movimiento varchar(100),
    coordenadar_geo      geography(Point, 4326) not null,
    calles               integer                not null
        constraint fk_calles
            references calles
);

alter table ubicacion_usuario
    owner to postgres;

create table usuario
(
    id_usuario         serial
        constraint pk_id_usuario
            primary key,
    nombre             varchar(50)  not null,
    nacionalidad       varchar(50)  not null,
    telefono           integer      not null,
    fecha_cumpleaños   date         not null,
    correo_electronico varchar(100) not null,
    vehiculo           integer      not null,
    ubicacion_usuario  integer      not null
        constraint fk_ubicacion_usuario
            references ubicacion_usuario
);

alter table usuario
    owner to postgres;

alter table ubicacion_usuario
    add constraint fk_id_usuario
        foreign key (id_usuario) references usuario;

create table vehiculo
(
    id_vehiculo       serial
        constraint fk_id_vehiculo
            primary key,
    tipo_vehiculo     integer     not null,
    placa             varchar(50) not null,
    color             varchar(50) not null,
    ubicacion_usuario integer     not null
        constraint fk_ubicacion_usuario
            references ubicacion_usuario,
    id_calles         integer     not null
        constraint fk_id_calles
            references calles
);

alter table vehiculo
    owner to postgres;



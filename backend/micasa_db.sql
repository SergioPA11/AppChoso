drop database if exists  micasa_db;
create database if not exists micasa_db;

use micasa_db;

drop table if exists users;
create table if not exists users (
    id int not null primary key auto_increment,
    name varchar(50) not null,
    password varchar(50) not null
);

drop table if exists families;
create table if not exists families (
    id int not null primary key auto_increment,
    name varchar(50) not null
);

drop table if exists user_family;
create table if not exists user_family (
    idFamily int,
    idUser int,
    isAdmin TinyInt default false,

    primary key (idFamily,idUser),
    foreign key (idFamily) references families(id)
    on delete cascade
    on update cascade,
    foreign key (idUser) references users(id)
    on delete cascade
    on update cascade
);

drop table if exists houses;
create table if not exists houses(
    id int not null auto_increment,
    idFamily int,
    name varchar(50) not null,

    primary key (id, idFamily),
    foreign key (idFamily) references families(id)
    on delete cascade 
    on update cascade
);

drop table if exists locations;
create table if not exists locations(
    id int not null auto_increment,
    idHome int, 
    name varchar(50) not null,

    primary key (id,idHome),
    foreign key (idHome) references houses(id)
    on delete cascade
    on update cascade
);

drop table if exists warehouses;
create table if not exists warehouses (
    id int not null auto_increment,
    idLocation int,
    name varchar(50) not null,

    primary key (id,idLocation),
    foreign key (idLocation) references locations(id)
    on delete cascade
    on update cascade
);

drop table if exists shelves;
create table if not exists shelves (
    id int not null auto_increment,
    idWarehouse int,

    primary key (id, idWarehouse),
    foreign key (idWarehouse) references warehouses(id)
    on delete cascade
    on update cascade
);

drop table if exists products;
create table if not exists products (
    id int not null primary key auto_increment,
    name varchar(50) not null,
    barCode varchar(13),
    min int,
    max int,
    price float
);

drop table if exists product_shelve;
create table if not exists product_shelve (
    idProduct int,
    idShelve int,
    number int,

    primary key (idProduct, idShelve),
    foreign key (idShelve) references shelves(id)
    on delete cascade
    on update cascade,
    foreign key (idProduct) references products(id)
    on delete cascade
    on update cascade
);

drop table if exists cart;
create table if not exists cart (
    id int not null primary key auto_increment,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    teorical_price float,
    real_price float
);

drop table if exists product_cart;
create table if not exists product_cart(
    idProduct int,
    idCart int,

    primary key (idProduct,idCart),
    foreign key (idProduct) references products(id)
    on delete cascade
    on update cascade,
    foreign key (idCart) references cart(id)
    on delete cascade
    on update cascade
);

drop table if exists monthy_payments;
create table if not exists monthy_payments (
    id int not null primary key auto_increment,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    name varchar(50) not null,
    price float not null
);
CREATE TABLE worker (
    Worker_id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    experience SMALLINT NOT NULL CHECK ( experience >= 0 )
);

CREATE TABLE manager (
    Manager_id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    job_title TEXT NOT NULL
);
CREATE TABLE work_order (
    Work_order_id BIGSERIAL PRIMARY KEY,
    manager_id BIGINT   NOT NULL REFERENCES manager(Manager_id),
    worker_id BIGINT NOT NULL REFERENCES worker(Worker_id),
    date_of_initialization DATE NOT NULl ,
    date_of_conclusion  DATE CHECK ( date_of_conclusion >= date_of_initialization )
);

CREATE TABLE location (
    Location_id BIGSERIAL PRIMARY KEY,
    square BIGINT NOT NULL CHECK (square > 0),
    type TEXT NOT NULL
);

CREATE TABLE exact_location (
    Exact_location_id BIGSERIAL PRIMARY KEY,
    place TEXT NOT NULL,
    height SMALLINT NOT NULL,
    location_id  BIGINT REFERENCES location(Location_id) NOT NULL
);

CREATE TABLE flag (
    Flag_id BIGSERIAL PRIMARY KEY,
    size SMALLINT NOT NULL,
    color TEXT NOT NULL,
    Exact_location_id BIGINT REFERENCES exact_location(Exact_location_id) NOT NULL UNIQUE ,
    work_order_id BIGINT REFERENCES work_order(Work_order_id) NOT NULL UNIQUE
);

CREATE TABLE decor (
    Decor_id BIGSERIAL PRIMARY KEY,
    main_pattern TEXT,
    main_pattern_material TEXT,
    color_of_main_pattern TEXT,
    additional_pattern TEXT,
    additional_pattern_material TEXT,
    color_of_additional_pattern TEXT
);

CREATE TABLE unique_design (
    flag_id BIGINT NOT NULL PRIMARY KEY,
    decor_id BIGINT NOT NULL PRIMARY KEY,

    FOREIGN KEY (flag_id)
        REFERENCES flag(Flag_id),

    FOREIGN KEY (decor_id)
        REFERENCES decor(Decor_id)
);


INSERT INTO worker (name, surname, experience)
VALUES
    ('Вася', 'Петров', 20),
    ('Петя', 'Иванов', 67),
    ('Степа', 'Сидоров', 0);

INSERT INTO manager (name, surname, job_title)
VALUES
    ('Александр', 'Джигурда', 'Старший менеджер'),
    ('Инокентий', 'Соболев', 'Стажер'),
    ('Владлен', 'Песков', 'Менеджер');

INSERT INTO work_order (manager_id, worker_id, date_of_initialization, date_of_conclusion)
VALUES
    (1,3 ,'2020-04-05' ,'2022-09-03'),
    (2, 1, '1995-12-26',null),
    (3, 2, '2017-04-02','2022-03-22');

INSERT INTO location (square, type)
VALUES
    (12, 'Остров'),
    (520, 'Полуостров'),
    (98989, 'Материк');

INSERT INTO exact_location (place, height, location_id)
VALUES
    ('Башня', 12, 2),
    ('Бастион', 18, 3),
    ('Церковь',7 , 1);

INSERT INTO flag (size, color, Exact_location_id, work_order_id)
VALUES
    (12, 'Черный', 2, 1),
    (8, 'Бирюзовый', 3,2 ),
    (19, 'Фиолетовый', 1, 3);

INSERT INTO decor (main_pattern, main_pattern_material, color_of_main_pattern, additional_pattern, additional_pattern_material, color_of_additional_pattern)
VALUES
    ( 'Звезда', 'Нить', 'Жёлтый', 'Полоска', 'Нить', 'Белый' ),
    ( 'Круг', 'Краска', 'Красный', null, NULL, NULL ),
    ( null, null, null, 'Рамка', 'Нить', 'Чёрный' );

INSERT INTO unique_design (flag_id, decor_id)
VALUES
    (1, 1),
    (2, 3),
    (3,2 ),
    (2, 1);
create database clinica;

use clinica;

create table pacientes (
	id_paciente int unsigned not null auto_increment,
    nome varchar(45) not null,
    sexo char(1) not null,
    idade int(11),
    doenca_inicial varchar(50),
    primary key (id_paciente)
);

create table registro_pacientes (
	id_registro int unsigned not null auto_increment primary key,
    data_hora datetime,
    nome_paciente varchar(50),
    sexo char(1),
    idade int,
    operacao varchar(255)
);

INSERT INTO pacientes (nome, sexo, idade, doenca_inicial) VALUES
('João', 'M', 25, 'Gripe'),
('Maria', 'F', 30, 'Resfriado'),
('Carlos', 'M', 40, 'Hipertensão'),
('Ana', 'F', 35, 'Diabetes'),
('Pedro', 'M', 28, 'Asma'),
('Juliana', 'F', 45, 'Artrite'),
('Fernando', 'M', 50, 'Insônia'),
('Luciana', 'F', 38, 'Enxaqueca'),
('Rafael', 'M', 32, 'Dor nas costas'),
('Mariana', 'F', 42, 'Depressão'),
('Gabriel', 'M', 29, 'Alergia'),
('Carolina', 'F', 33, 'Estresse'),
('Diego', 'M', 37, 'Úlcera'),
('Beatriz', 'F', 48, 'Fibromialgia'),
('Rodrigo', 'M', 31, 'Rinite'),
('Camila', 'F', 36, 'Ansiedade'),
('Marcelo', 'M', 39, 'Obesidade'),
('Isabela', 'F', 41, 'Colesterol alto'),
('Alexandre', 'M', 27, 'Dor de cabeça'),
('Tatiane', 'F', 43, 'Tendinite'),
('Guilherme', 'M', 26, 'Dor abdominal'),
('Aline', 'F', 34, 'Câimbras'),
('Vinícius', 'M', 44, 'Insuficiência renal'),
('Natália', 'F', 49, 'Enfisema pulmonar'),
('Felipe', 'M', 23, 'Dor no joelho'),
('Patrícia', 'F', 46, 'Hipotireoidismo'),
('Eduardo', 'M', 24, 'Dor no peito'),
('Larissa', 'F', 47, 'Esclerose múltipla'),
('Leonardo', 'M', 22, 'Dor lombar');

DROP TRIGGER IF EXISTS tg_inserirpaciente;
DELIMITER $$
	-- DROP TRIGGER IF EXISTS tg_inserirpaciente;
    CREATE TRIGGER tg_inserirpaciente AFTER INSERT ON pacientes
    FOR EACH ROW
		BEGIN
			INSERT INTO registro_pacientes(nome_paciente, sexo, idade, data_hora, operacao) values
            (new.nome, new.sexo, new.idade, NOW(), 'evento INSERT na tabela pacientes');
		END
$$ DELIMITER ;

DROP TRIGGER IF EXISTS tg_atualizapaciente;
DELIMITER $$
	-- DROP TRIGGER IF EXISTS tg_atualizapaciente;
    CREATE TRIGGER tg_atualizapaciente AFTER UPDATE ON pacientes
    FOR EACH ROW
		BEGIN
			INSERT INTO registro_pacientes(nome_paciente, sexo, idade, data_hora, operacao) values
            (new.nome, new.sexo, new.idade, NOW(), CONCAT('paciente ', old.nome, ' teve seus dados modificados'));
		END
$$ DELIMITER ;

DROP TRIGGER IF EXISTS tg_apagapaciente;
DELIMITER $$
	-- DROP TRIGGER IF EXISTS tg_apagapaciente;
    CREATE TRIGGER tg_apagapaciente BEFORE DELETE ON pacientes
    FOR EACH ROW
		BEGIN
			INSERT INTO registro_pacientes(nome_paciente, sexo, idade, data_hora, operacao) values
            (old.nome, old.sexo, old.idade, NOW(), CONCAT('paciente ', old.nome, ' teve seus dados removidos'));
		END
$$ DELIMITER ;

UPDATE pacientes
SET nome = 'Gean'
WHERE nome = 'João';

DELETE FROM pacientes
WHERE id_paciente = 3;

START TRANSACTION;
    DELETE FROM pacientes
    WHERE id_paciente = 7;
COMMIT;

SELECT * FROM registro_pacientes;
SELECT * FROM pacientes;



CREATE VIEW PACIENTES_VIEW_RECEPCAO AS
SELECT id_paciente,nome,sexo,idade
FROM PACIENTES;

SELECT * FROM PACIENTES_VIEW_RECEPCAO;

drop table medicos;

create table medicos(
id_medico int unsigned not null auto_increment,
nome varchar(45) not null,
crm varchar(45) not null,
salario float not null,
idade int(11),
primary key (id_medico));

create table consultas(
id_medico int unsigned not null,
id_paciente int unsigned not null,
dia date not null,
hora time not null,
primary key (id_medico, id_paciente),
foreign key (id_medico) references medicos(id_medico),
foreign key (id_paciente) references pacientes(id_paciente));



insert into medicos (nome, crm, salario, idade) values
('Dr. João', '12345-SP', 10000, 35),
('Dr. Maria', '54321-RJ', 9500, 40),
('Dr. Ana', '98765-SP', 10500, 45),
('Dr. Pedro', '24680-RJ', 11000, 38),
('Dr. Laura', '13579-SP', 9800, 42),
('Dr. Carlos', '98765-RJ', 10200, 37),
('Dr. Sofia', '65432-SP', 9700, 39),
('Dr. Rafael', '54321-SP', 9600, 41),
('Dr. Luana', '24680-SP', 10300, 36),
('Dr. Thiago', '13579-RJ', 10800, 43);

insert into consultas (id_medico, id_paciente, dia, hora) values
(1, 1, '2024-05-17', '08:00:00'),
(1, 2, '2024-05-17', '09:00:00'),
(1, 3, '2024-05-17', '10:00:00'),
(1, 4, '2024-05-17', '11:00:00'),
(1, 5, '2024-05-17', '12:00:00'),
(1, 6, '2024-05-17', '13:00:00'),
(1, 7, '2024-05-17', '14:00:00'),
(1, 8, '2024-05-17', '15:00:00'),
(1, 9, '2024-05-17', '16:00:00'),
(1, 10, '2024-05-17', '17:00:00'),
(2, 1, '2024-05-17', '08:00:00'),
(2, 2, '2024-05-17', '09:00:00'),
(2, 3, '2024-05-17', '10:00:00'),
(2, 4, '2024-05-17', '11:00:00'),
(2, 5, '2024-05-17', '12:00:00'),
(2, 6, '2024-05-17', '13:00:00'),
(2, 7, '2024-05-17', '14:00:00'),
(2, 8, '2024-05-17', '15:00:00'),
(2, 9, '2024-05-17', '16:00:00'),
(2, 10, '2024-05-17', '17:00:00');

CREATE VIEW VIEW_CONSULTA AS
SELECT P.ID_PACIENTE,P.NOME AS NOME_PACIENTE,P.SEXO,P.IDADE AS IDADE_PACIENTE,P.DOENCA_INICIAL,M.*,C.DIA,C.HORA
FROM CONSULTAS AS C
INNER JOIN MEDICOS AS M ON C.ID_MEDICO = M.ID_MEDICO
INNER JOIN PACIENTES AS P ON C.ID_PACIENTE = P.ID_PACIENTE
WHERE C.DIA = CURDATE()
ORDER BY C.DIA DESC;

CREATE VIEW VIEW_MEDICOS_LIVRES AS 
SELECT M.NOME AS "MÉDICO",C.DIA AS "DATA CONSULTA"
FROM MEDICOS AS M
LEFT JOIN CONSULTAS AS C
ON M.ID_MEDICO = C.ID_MEDICO
WHERE C.ID_MEDICO IS NULL;

-- LISTAGEM COM A QUANTIDADE DE PACIENTES AGRUPADOS POR DOENÇA.
CREATE VIEW VIEW_QUANT_PACIENTES AS
SELECT P.DOENCA_INICIAL,count(*) AS QUANTIDADE
FROM PACIENTES AS P
GROUP BY P.DOENCA_INICIAL;

-- LISTAGEM DOS MÉDICOS COM SALÁRIO ACIMA DA MÉDIA SALARIAL ORDENADA POR SALÁRIO DECRECENTE.
CREATE VIEW VW_MEDICOS_ACIMA_MEDIA AS 
SELECT M.NOME, M.SALARIO, (SELECT AVG(SALARIO) FROM MEDICOS) AS "MÉDIA SALARIAL"
FROM MEDICOS AS M
WHERE M.SALARIO > (SELECT AVG(SALARIO) FROM MEDICOS)
ORDER BY M.SALARIO DESC;

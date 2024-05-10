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
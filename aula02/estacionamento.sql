PRAGMA foreign_keys = ON;

-- CRIAÇÃO DE TABLEAS
CREATE TABLE IF NOT EXISTS Clientes
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cpf TEXT NOT NULL UNIQUE,
    telefone TEXT
);

CREATE TABLE IF NOT EXISTS Veiculos
(
    id INTEGER PRIMARY KEY  AUTOINCREMENT,
    cliente_id INTERGER NOT NULL,
    placa TEXT NOT NULL UNIQUE,
    modelo TEXT NOT NULL,
    cor TEXT,
    FOREIGN KEY (cliente_id) REFERENCES Clientes (id) ON DELETE CASCADE
);

-- INSERÇÃO DE DADOS
INSERT INTO Clientes (nome, cpf, telefone) VALUES
('Fulano Cicrano', '11111111111', '11911111111'),
('Ana Carolina', '22222222222', '11922222222'),
('Maria Eduarda', '33333333333', '11933333333'),
('Carlos Eduardo', '44444444444', '11944444444');

INSERT INTO Veiculos (cliente_id, placa, modelo, cor) VALUES
(1, 'ABC1D23', 'Chevrolet Onix', 'Azul'),
(2, 'EFG4H56', 'Hyundai HB20', 'Cinza'),
(2, 'IJK7L89', 'Jeep Compass', 'Verde'),
(3, 'MNO0P12', 'Toyota Corolla Cross', 'Preto'),
(3, 'QRS3T45', 'Porsche Carrera', 'Vermelho'),
(3, 'UVW6X78', 'BMW M3', 'Roxo'),
(4, 'YZA9B01', 'BYD Dolphin', 'Branco');

-- CONSULTA DE DADOS
SELECT * FROM Clientes;
SELECT * FROM Veiculos;


-- DELEÇÃO DE DADOS
PRAGMA foreign_keys = ON;
DELETE FROM Clientes WHERE id = 2;

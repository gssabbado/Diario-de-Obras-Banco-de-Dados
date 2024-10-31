from posixpath import join

-- Tabelas de Entidade
CREATE TABLE Empresa (
    CodEmpresa INT PRIMARY KEY,
    CNPJ VARCHAR(14) NOT NULL
);

CREATE TABLE Mao_de_Obra (
    CodFuncionario INT PRIMARY KEY,
    Foto BLOB, -- tipo de dados para armazenar imagens
    Salario DECIMAL(10, 2), -- no máximo 10 dígitos, com até duas casas decimais
    RG VARCHAR(20),
    CPF VARCHAR(11) UNIQUE,
    Cargo VARCHAR(50),
    Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Obra (
    CodObra INT PRIMARY KEY,
    Endereco VARCHAR(255),
    Fotos BLOB,
    Data_inicio DATE,
    Data_previsao DATE
);

CREATE TABLE Proprietario (
    CodProp INT PRIMARY KEY,
    NomeProp VARCHAR(100),
    CPF VARCHAR(11) UNIQUE
);

CREATE TABLE Diario (
    CodDiario INT PRIMARY KEY,
    Endereco VARCHAR(255),
    Fotos BLOB,
    Obs_Geral TEXT,
    Obs_Func TEXT,
    Data DATE,
    Horario_Trabalho TIME,
    Clima VARCHAR(50)
);

CREATE TABLE Equipamentos (
    CodEquipamento INT PRIMARY KEY,
    Tipo VARCHAR(50),
    Marca VARCHAR(50)
);

CREATE TABLE Materiais (
    CodMaterial INT PRIMARY KEY,
    Tipo VARCHAR(50),
    Quantidade INT,
    Unidade VARCHAR(5),
    Custo DECIMAL(10, 2)
);

CREATE TABLE Residuos (
    Classe VARCHAR(50),
    PA_CodPlano INT,
    PRIMARY KEY (Classe, CodPlano),
    FOREIGN KEY (PA_CodPlano) REFERENCES Plano_de_Aproveitamento(CodPlano)
);

-- Tabela de Especialização
CREATE TABLE Plano_de_Aproveitamento (
    CodPlano INT PRIMARY KEY,
    Descricao TEXT,
    Emp_Empresa INT,
    FOREIGN KEY (Emp_Empresa) REFERENCES Empresa(CodEmpresa)
);

-- Tabelas de Relacionamento
CREATE TABLE Cadastro (
    Cad_CodEmpresa INT,
    Cad_CodObra INT,
    Cad_CodFuncionario INT,
    PRIMARY KEY (Cad_CodEmpresa, Cad_CodObra, Cad_CodFuncionario),
    FOREIGN KEY (Cad_CodEmpresa) REFERENCES Empresa(CodEmpresa),
    FOREIGN KEY (Cad_CodObra) REFERENCES Obra(CodObra),
    FOREIGN KEY (Cad_CodFuncionario) REFERENCES Mão_de_Obra(CodFuncionario)
);

CREATE TABLE Contrato (
    Cont_CodEmpresa INT,
    Cont_CodObra INT,
    Cont_CodProp INT,
    PRIMARY KEY (Cont_Empresa, Cont_CodObra, Cont_CodProp),
    FOREIGN KEY (Cont_CodEmpresa) REFERENCES Empresa(CodEmpresa),
    FOREIGN KEY (Cont_CodObra) REFERENCES Obra(CodObra),
    FOREIGN KEY (Cont_CodProp) REFERENCES Proprietário(CodProp)
);

CREATE TABLE Trabalho (
    Trab_CodObra INT,
    Trab_CodFuncionario INT,
    PRIMARY KEY (Trab_CodObra, Trab_CodFuncionario),
    FOREIGN KEY (Trab_CodObra) REFERENCES Obra(CodObra),
    FOREIGN KEY (Trab_CodFuncionario) REFERENCES Mão_de_Obra(CodFuncionario)
);

CREATE TABLE Aluguel (
    Alug_CodEquipamento INT PRIMARY KEY,
    Valor DECIMAL(10, 2),
    Periodo INT,
    FOREIGN KEY (Alug_CodEquipamento) REFERENCES Equipamentos(CodEquipamento)
    FOREIGN KEY (Alug_CodDiario) REFERENCES Diario(CodDiario)
);

CREATE TABLE Recebimento (
    Receb_CodDiario INT,
    Receb_CodMaterial INT,
    PRIMARY KEY (Receb_CodDiario, Receb_CodMaterial),
    FOREIGN KEY (Receb_CodDiario) REFERENCES Diario(CodDiario),
    FOREIGN KEY (Receb_CodMaterial) REFERENCES Materiais(CodMaterial)
);

CREATE TABLE Uso (
    Uso_CodMaterial INT,
    Uso_Classe VARCHAR(50),
    Inicial VARCHAR(70), --Alterei o tipo de dado
    Subsequente VARCHAR(70),
    PRIMARY KEY (Uso_CodMaterial, Uso_Classe),
    FOREIGN KEY (Uso_CodMaterial) REFERENCES Materiais(CodMaterial),
    FOREIGN KEY (Uso_Classe) REFERENCES Resíduos(Classe)
);

-- Inserção de dados na tabela Empresa
INSERT INTO Empresa (CddEmpresa, CNPJ) VALUES
(1, '12345678000100'),
(2, '12345678000101'),
(3, '12345678000102'),
(4, '12345678000103'),
(5, '12345678000104'),
(6, '12345678000105'),
(7, '12345678901234'),
(8, '56789012345678'),
(9, '90123456789012'),
(10, '34567890123456'),
(11, '78901234567890'),
(12, '23456789012345');

-- Inserção de dados na tabela Mão_de_Obra
INSERT INTO Mao_de_Obra (CodFuncionario, Foto, Salario, RG, CPF, Cargo, Nome) VALUES
(1, NULL, 10000.00, '123456789', '12300000800', 'Engenheiro', 'Robson Neves'),
(2, NULL, 8000.00, '123456788', '32100000800', 'Eletricista', 'Joana Nunes'),
(3, NULL, 25000.00, '123456787', '45600000800', 'Engenheiro Civil', 'Johann Strauss'),
(4, NULL, 4000.00, '123456786', '65400000800', 'Pedreiro', 'Robert Denilson'),
(5, NULL, 7500.00, '123456785', '78900000800', 'Arquiteto', 'Sol da Silva'),
(6, NULL, 6500.00, '123456784', '98700000800', 'Engenheiro', 'Julie Powers');
(7, 'caminho_foto7.jpg', 3000.00, '123456701', '78901234567', 'Pedreiro', 'João da Silva'),
(8, 'caminho_foto8.jpg', 2500.00, '765432102', '45678901234', 'Eletricista', 'Maria Oliveira'),
(9, 'caminho_foto9.jpg', 3500.00, '987654303', '12345678901', 'Encanador', 'Carlos Souza'),
(10, 'caminho_foto10.jpg', 2800.00, '345678904', '56789012345', 'Carpinteiro', 'Ana Santos'),
(11, 'caminho_foto11.jpg', 3200.00, '876543205', '90123456789', 'Pintor', 'Roberto Lima'),
(12, 'caminho_foto12.jpg', 3000.00, '234567806', '34567890123', 'Mestre de Obras', 'Luiza Fernandes');


-- Inserção de dados na tabela Obra
INSERT INTO Obra (CodObra, Endereco, Fotos, Data_inicio, Data_previsao) VALUES
(1, 'Avenida Trobson Azambuja', NULL, '2023-05-11', '2025-06-21'),
(2, 'Avenida Relâmpago Marquinhos', NULL, '2024-08-03', '2027-03-17'), -- Alterei só a data (ANA)
(3, 'Avenida Paulista', NULL, '2023-07-25', '2025-08-20'),
(4, 'Rua Alexandre de Matos', NULL, '2023-08-21', '2028-01-01'),
(5, 'Rua Pennywise', NULL, '2021-04-07', '2023-12-19'),
(6, 'Rua Mitocôndria Azul', NULL, '2022-01-107', '2024-12-11'),
(7, 'Rua A, 123', 'caminho_foto_obra7.jpg', '2025-12-07', '2028-06-10'), -- Alterei só a data (ANA)
(8, 'Avenida B, 456', 'caminho_foto_obra8.jpg', '2023-02-15', '2023-08-15'),
(9, 'Rua C, 789', 'caminho_foto_obra9.jpg', '2025-03-20', '2029-09-20'), -- Alterei só a data (ANA)
(10, 'Avenida D, 101', 'caminho_foto_obra10.jpg', '2023-04-25', '2025-10-25'),
(11, 'Rua E, 112', 'caminho_foto_obra11.jpg', '2021-05-30', '2024-11-30'),
(12, 'Avenida F, 213', 'caminho_foto_obra12.jpg', '2023-06-05', '2026-12-05');


-- Inserção de dados na tabela Proprietário
INSERT INTO Proprietario (CodProp, NomeProp, CPF) VALUES
(1, 'Gideon Graves', '12355500812'),
(2, 'Ken Masters', '32306578450'),
(3, 'Sypha Belnades', '82468675806'),
(4, 'Ramza Beoulve', '10987654321'),
(5, 'Raimundo Rodrigues', '17368055896'),
(6, 'Patinhas McPato', '27334945857');
(7, 'José Silva', '98765432109'),
(8, 'Ana Oliveira', '54321098765'),
(9, 'Carlos Pereira', '10987654321'),
(10, 'Marina Souza', '87654321098'),
(11, 'Fernando Lima', '43210987654'),
(12, 'Camila Santos', '21098765432');

-- Inserção de dados na tabela Diário
INSERT INTO Diario (CodDiario, Endereco, Fotos, Obs_Geral, Obs_Func, Data, Horario_Trabalho, Clima) VALUES
(1, 'Rua Alexandre de Matos', NULL, 'Construção em Andamento', 'Eletricista terminou a fiação', '12-10-2026', '09:00-19:00', 'Parcialmente Nublado'),
(2, 'Rua Alexandre de Matos', NULL, 'Acidente com o Engenheiro', 'Engenheiro conferiu se vai ser necessário levantar a viga do salão, um pedaço de madeira caiu em cima dele.', '19-01-2027', '08:00-17:00', 'Ensolarado' ),
(3, 'Avenida Trobson Azambuja', NULL, 'Caminhões do concreto chegaram atrasados.', 'Arquiteto conferiu a planta da obra.', '06-03-2024', '07:30-16:30', 'Chuva Fraca'),
(4, 'Avenida Relâmpago Marquinhos', NULL, 'Problema de filtração no banheiro', 'Pedreiro começou a tirar o rejunte antigo.', '17-11-2023', '08:00-17:00', 'Nublado'),
(5, 'Avenida Relâmpago Marquinhos', NULL, 'Obra em andamento', 'Arquiteto conferiu a mudança do salão principal.',   '19-05-2024', '08:30-18:00', 'Nublado'),
(6, 'Avenida Relâmpago Marquinhos', NULL, 'Obra quase finalizada', 'Engenheiro conferiu a o descarte perigosos.', '25-01-2026', '10:00-17:30', 'Chuvoso'),
(7, 'Rua A, 123', 'caminho_foto_diario1.jpg', 'N/A', 'Equipe produtiva, bom progresso hoje.', '2023-01-10', '08:00-17:00', 'Ensolarado'),
(8, 'Avenida B, 456', 'caminho_foto_diario2.jpg', 'Atenção: Vazamento detectado na tubulação principal.', 'Equipe de encanadores acionada.', '2023-02-15', '08:30-18:00', 'Chuvoso'),
(9, 'Rua C, 789', 'caminho_foto_diario3.jpg', 'N/A', 'Dia tranquilo, sem incidentes.', '2023-03-20', '08:00-17:30', 'Nublado'),
(10, 'Avenida D, 101', 'caminho_foto_diario4.jpg', 'Atenção: Atraso na entrega de materiais.', 'Equipe de logística notificada.', '2023-04-25', '09:00-18:00', 'Ensolarado'),
(11, 'Rua E, 112', 'caminho_foto_diario5.jpg', 'N/A', 'Conclusão da estrutura principal.', '2023-05-30', '07:30-16:30', 'Parcialmente nublado'),
(12, 'Avenida F, 213', 'caminho_foto_diario6.jpg', 'Atenção: Equipamento danificado.', 'Equipe de manutenção trabalhando no reparo.', '2023-06-05', '08:00-17:00', 'Chuvoso');


-- Inserção de dados na tabela Equipamentos
INSERT INTO Equipamentos (CodEquipamento, Tipo, Marca) VALUES
(1, 'EPI', 'MSA'),
(2, 'EPI', 'Marluvas'),
(3, 'EPI', '3M'),
(4, 'Retroescavadeira', 'Armac'),
(5, 'Betoneira', 'Armac'),
(6, 'Trator', 'John Deere'),
(7, 'Escavadeira', 'Caterpillar'),
(8, 'Betoneira', 'Bosch'),
(9, 'Guincho', 'Hercules'),
(10, 'Serra Elétrica', 'DeWalt'),
(11, 'Martelo Pneumático', 'Makita'),
(12, 'Empilhadeira', 'Toyota');

-- Inserção de dados na tabela Materiais
INSERT INTO Materiais (CodMaterial, Tipo, Quantidade, Unidade, Custo) VALUES
(1, 'Lixas', 500, 'm', 1800.00),
(2, 'Tijolos', 3000, 'unid', 1000.00),
(3. 'Brita', 1500, 'm3', 1525.00),
(4, 'Tubos', 200, 'm', 450.00),     -- m é metro linear
(5, 'Concreto', 1300, 'm3', 1900.00), -- m3 é metro cubico
(6, 'Espuma isolante', 50, 'unid', 1500.00), -- unid é unidades
(7, 'Cimento', 1000, 'sc50', 800.00), -- sc50 é saco de 50kg
(8, 'Vergalhao de Aço', 3000, 'm',2500.00),
(9, 'Massa Corrida', 9, 'kg', 350.00),
(10, 'Tintas', 50, 'unid', 200.00),
(11, 'Telhas', 100, 'm3', 300.00),
(12, 'Vidros', 30, 'm', 400.00);

-- Inserção de dados na tabela Resíduos
INSERT INTO Residuos (Classe, PA_CodPlano) VALUES
('Classe C', 1),
('Classe A', 2),
('Classe A', 3),
('Classe B', 4),
('Classe A', 5),
('Classe F', 6),
('Classe A', 7),
('Classe B', 8),
('Classe C', 9),
('Classe D', 10),
('Classe A', 11),
('Classe B', 12);

-- Inserção de dados na tabela Plano_de_Aproveitamento
INSERT INTO Plano_de_Aproveitamento (CodPlano, Descricao, Emp_Empresa) VALUES
(1, 'Plano A: resíduo C - reciclados e/ou recuperação', 1),
(2, 'Plano B: resíduo A - reciclagem e/ou reaproveitamento', 2),
(3, 'Plano C: resíduo A - reciclagem e/ou reaproveitamento', 3),
(4, 'Plano D: resíduo B - reciclagem e/ou reaproveitamento', 4),
(5, 'Plano E: resíduo A - reciclagem e/ou reaproveitamento', 5),
(6, 'Plano F: resíduos F - manuseio e tratamento especial', 6),
(7, 'Plano G: resíduo A - reciclagem e/ou reaproveitamento', 7),
(8, 'Plano H: resíduo B - reciclagem e/ou reaproveitamento', 8),
(9, 'Plano I: resíduo C - reciclados e/ou recuperação', 9),
(10, 'Plano J: resíduo D - PERIGOSO E POLUENTE! Manuseio e tratamento especial', 10),
(11, 'Plano K: resíduo A - reciclagem e/ou reaproveitamento', 11),
(12, 'Plano L: resíduo B - reciclagem e/ou reaproveitamento', 12);

-- Inserção de dados na tabela Cadastro
INSERT INTO Cadastro (Cad_CodEmpresa, Cad_CodObra, Cad_CodFuncionario) VALUES
(1, 8, 9),
(2, NULL, 8),  -- Algumas obras estão como NULL, podemos determinar esse cenário como uma obra "não iniciada"
(3, 10, 7),
(4, 11, 6),
(5, 12, 5),
(6, 1, 4),
(7, NULL, 3)
(8, 8, 2),
(9, NULL, 1),
(10, 5, 12),
(11, 6, 11),
(12, 7, 10);

-- Inserção de dados na tabela Contrato
INSERT INTO Contrato (Cont_CodEmpresa, Cont_CodObra, Cont_CodProp) VALUES
(1, 8, 9),
(2, NULL, 8),
(3, 10, 7),
(4, 11, 6),
(5, 12, 5),
(6, 1, 4),
(7, NULL, 3)
(8, 8, 2),
(9, NULL, 1),
(10, 5, 12),
(11, 6, 11),
(12, 7, 10);

-- Inserção de dados na tabela Trabalho
INSERT INTO Trabalho (Trab_CodObra, Trab_CodFuncionario) VALUES
(1, 1),
(6, 2), -- Obra 6: funcionário 2 e 6. Alguns funcionarios irão trabalhar em duas obras diferentes
(3, 3), -- Obra 3: funcionário 3 e 7
(4, 4),
(5, 5),
(6, 6), -- Obra 6: funcionário 2 e 6
(3, 7),  -- Obra 3: funcionário 3 e 7
(8, 8),
(12, 9), -- Obra 12: funcionário 9 e 12
(10, 10),
(11, 11),
(12, 12); -- Obra 12: funcionário 9 e 12

-- Inserção de dados na tabela Aluguel
INSERT INTO Aluguel (Alug_CodEquipamento, Valor, Período) VALUES
(1, 215.00, 30),
(2, 140.00, 20),
(3, 175.00, 15),
(4, 1850.00, 10),
(5, 1525.00, 25),
(6, 1900.00, 12),
(7, 2150.00, 18);
(8, 200.00, 30),
(9, 150.00, 20),
(10, 570.00, 15),
(11, 120.00, 10),
(12, 1675.00, 25);

-- Inserção de dados na tabela Recebimento
INSERT INTO Recebimento ( Receb_CodDiario, Receb_CodMaterial) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12);

-- Inserção de dados na tabela Uso
INSERT INTO Uso (Uso_CodMaterial, Uso_Classe, Inicial, Subsequente) VALUES
(1, 'Classe C', 'Lixamento e acabamento - Geral', 'Material de base'), -- Definido como "material de base" os que serão reciclados para desenvolver outros materiais gerais de construção
(2, 'Classe A', 'Alvenaria - Geral', 'Tijolos'),
(3, 'Classe A', 'Pavimentação - Geral', 'Material de base'),
(4, 'Classe B', 'Sistema hidráulico', 'Material de base'),
(5, 'Classe A', 'Revestimento - Banheiro', 'Não reaproveital'),
(6, 'Classe F', 'Isolação térmica - Quarto', NULL) -- Definido como nulo os materiais que precisam de tratamento específico
(7, 'Classe A', 'Produção concreto - Geral', 'Material de base'),
(8, 'Classe B', 'Reforço em estrutura - Geral', 'Aço reciclado'),
(9, 'Classe C', 'Preparação de superfície - Geral', 'Massa corrida'),
(10, 'Classe D', 'Pintura - Segundo andar', NULL),
(11, 'Classe A', 'Cobertura - Teto', 'Material de base'),
(12, 'Classe B', 'Cobertura - Janelas', 'Material de base');


---------- Cinco consultas com operadores básicos e junção de, no mínimo, duas tabelas ----------
-- 1. Consultar nome, classe e uso dos mateirias que geram resíduos que precisa de tratamento especial
SELECT M.Tipo, R.Classe, U.Inicial
FROM Materiais M
JOIN Uso U ON M.CodMaterial = U.Uso_CodMaterial
JOIN Residuos R ON R.Classe = U.Uso_Classe
WHERE U.Subsequente IS NULL;

-- 2. Consultar os materiais, as classes e reusos dos materiais que geram resíduos recicláveis ou reutilizavéis
SELECT M.Materiais, R.Classe, U.Subsequente
FROM Materiais M
JOIN Uso U ON M.CodMaterial = U.Uso_CodMaterial
JOIN Residuos R ON U.Uso_Classe = R.Classe
WHERE U.Subsequente IS NOT NULL;

-- 3. Consultar nome e em qual obra os funcionários trabalham
SELECT MO.Nome AS NomeFuncionario, O.CodObra AS Obra
FROM Mao_de_Obra MO
JOIN Cadastro C ON MO.CodFuncionario = C.Cad_CodFuncionario
JOIN Obra O ON C.Cad_CodObra = O.CodObra
GROUP BY NomeFuncionario, Obra;

-- 4. Consultar responsável, data de conclusão (da data mais próxima para a menos próxima) e observação das obras
SELECT P.NomeProp AS Responsavel, O.Data_previsao AS 'Data de Conclusão', O.Obs_Geral
FROM Proprietario P
JOIN Contrato C ON P.CodProp = C.Cont_CodProp
JOIN Obra O ON C.Cont_CodObra = O.CodObra
ORDER BY 'Data de Conclusão' ASC;

-- 5. PENDENTE!!! Consultar quais obras não foram iniciadas, mostrar seu código e seu endereço e o nome do proprietário
SELECT O.CodObra, O.Endereco, PROP.NomeProp
FROM Obra O
JOIN Cadastro CAD ON O.CodObra = CAD.Cad_CodObra
JOIN Contrato C ON O.CodObra = C.Cont_CodObra
JOIN Proprietario PROP ON C.Cont_CodProp = PROP.CodProp
WHERE C.Cont_Obra IS NULL;


---------- Duas consultas com LEFT JOIN ----------
-- 6. Consultar obras não iniciadas e qual a previsão da finalização delas, caso a obra não tenha previsão, deve aparecer no retorno mesmo assim.
SELECT O.Endereco AS Obra, O.Data_previsao AS 'Data de Previsão'
FROM Contrato C
LEFT JOIN Obra O ON C.CodObra = O.CodObra
WHERE C.CodCadastro IS NULL; -- Obras sem cadastro respresentam obras não iniciadas

-- 7. Consultar o tipo de equipamento, marca e aluguel em ordem decrescente (maior para menor). Caso não tenha registro de aluguel, manter no retorno
SELECT E.Tipo, E.Marca, A.Valor
FROM Equipamentos E
LEFT JOIN Aluguel A ON E.CodEquipamento = A.CodEquipamento
ORDER BY A.Valor DESC;

----------  5 consultas com os operadores (avg, sum, etc.) usando group by, having e order by ----------
8. Consultar o maior e o menor salário com o nome do respectivo funcionário e em qual obra ele atua
SELECT MO.Nome AS NomeFuncionario, O.CodObra AS Obra, MAX(MO.Salario) AS MaiorSalario, MIN(MO.Salario) AS MenorSalario
FROM Mao_de_Obra MO
JOIN Cadastro C ON MO.CodFuncionario = C.Cad_CodFuncionario
JOIN Obra O ON C.Cad_CodObra = O.CodObra
GROUP BY NomeFuncionario, Obra;

9. Consultar a quantidade de funcionários em cada obra e o endereço de cada obra, ordenando da maior quantidade de funcionarios até a menor
SELECT O.Endereco, COUNT(MO.CodFuncionario) AS QtdFunc
FROM Obra O, Mao_de_Obra MO, Cadastro C
WHERE O.CodObra = C.Cad_CodObra
AND C.Cad_CodFuncionario = MO.CodFuncionario
GROUP BY O.Endereco
ORDER BY QtdFunc DESC;


10. Consultar a média de preço dos materiais usados nas obras, e depois mostrar os materiais estão acima da média
SELECT M.Tipo, M.Valor AS ValorMaterial
FROM Materiais M
WHERE M.Valor > (
    SELECT AVG(M2.Valor)
    FROM Materiais M2
    WHERE M2.Tipo = M.Tipo
)
GROUP BY M.Tipo;

11. Consultar a média de preço dos equipamentos e mostrar os tipos equipamentos estão abaixo da média
SELECT E.Tipo, E.Valor AS ValorEquipamento
FROM Equipamentos E
WHERE E.Valor < (
    SELECT AVG(E2.Valor)
    FROM Equipamentos E2
    WHERE E2.Tipo = E.Tipo
)
GROUP BY E.Tipo;


12. Consultar a quantidade de materiais que estão nas classes A e C, e mostrar a quantidade de cada classe
SELECT R.Classe, COUNT(*) AS Quantidade
FROM Residuos R
WHERE R.Classe IN ('Classe A', 'Classe C')
GROUP BY R.Classe;


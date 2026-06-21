IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Recipes] (
    [RecipeId] int NOT NULL IDENTITY,
    [Title] nvarchar(max) NOT NULL,
    [Description] nvarchar(max) NOT NULL,
    [Ingredients] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Recipes] PRIMARY KEY ([RecipeId])
);
GO

CREATE TABLE [Users] (
    [UserId] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [Password] nvarchar(max) NOT NULL,
    [RecipeId] int NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY ([UserId]),
    CONSTRAINT [FK_Users_Recipes_RecipeId] FOREIGN KEY ([RecipeId]) REFERENCES [Recipes] ([RecipeId]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'RecipeId', N'Description', N'Ingredients', N'Title') AND [object_id] = OBJECT_ID(N'[Recipes]'))
    SET IDENTITY_INSERT [Recipes] ON;
INSERT INTO [Recipes] ([RecipeId], [Description], [Ingredients], [Title])
VALUES (1, N'A traditional dish made with rice, meat, and yogurt sauce.', N'Rice, meat, yogurt sauce, almonds, bread', N'Mansaf');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'RecipeId', N'Description', N'Ingredients', N'Title') AND [object_id] = OBJECT_ID(N'[Recipes]'))
    SET IDENTITY_INSERT [Recipes] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'RecipeId', N'Description', N'Ingredients', N'Title') AND [object_id] = OBJECT_ID(N'[Recipes]'))
    SET IDENTITY_INSERT [Recipes] ON;
INSERT INTO [Recipes] ([RecipeId], [Description], [Ingredients], [Title])
VALUES (2, N'A traditional rice dish cooked with chicken, vegetables, and spices.', N'Rice, chicken, eggplant, cauliflower, potatoes, spices', N'Maqluba');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'RecipeId', N'Description', N'Ingredients', N'Title') AND [object_id] = OBJECT_ID(N'[Recipes]'))
    SET IDENTITY_INSERT [Recipes] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'UserId', N'Email', N'Name', N'Password', N'RecipeId') AND [object_id] = OBJECT_ID(N'[Users]'))
    SET IDENTITY_INSERT [Users] ON;
INSERT INTO [Users] ([UserId], [Email], [Name], [Password], [RecipeId])
VALUES (1, N'w.abudawas@student.aaup.edu', N'Walaa Abudawas', N'1234', 1);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'UserId', N'Email', N'Name', N'Password', N'RecipeId') AND [object_id] = OBJECT_ID(N'[Users]'))
    SET IDENTITY_INSERT [Users] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'UserId', N'Email', N'Name', N'Password', N'RecipeId') AND [object_id] = OBJECT_ID(N'[Users]'))
    SET IDENTITY_INSERT [Users] ON;
INSERT INTO [Users] ([UserId], [Email], [Name], [Password], [RecipeId])
VALUES (2, N'r.daraghmeh22@student.aaup.edu', N'Reem Daraghmeh', N'5678', 2);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'UserId', N'Email', N'Name', N'Password', N'RecipeId') AND [object_id] = OBJECT_ID(N'[Users]'))
    SET IDENTITY_INSERT [Users] OFF;
GO

CREATE INDEX [IX_Users_RecipeId] ON [Users] ([RecipeId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260615142148_InitialCreate', N'6.0.0');
GO

COMMIT;
GO


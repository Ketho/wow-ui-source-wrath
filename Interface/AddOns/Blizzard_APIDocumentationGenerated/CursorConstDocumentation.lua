local CursorConst =
{
	Tables =
	{
		{
			Name = "CursorStyle",
			Type = "Enumeration",
			NumValues = 2,
			MinValue = 0,
			MaxValue = 1,
			Fields =
			{
				{ Name = "Mouse", Type = "CursorStyle", EnumValue = 0 },
				{ Name = "Crosshair", Type = "CursorStyle", EnumValue = 1 },
			},
		},
		{
			Name = "Cursormode",
			Type = "Enumeration",
			NumValues = 66,
			MinValue = 0,
			MaxValue = 65,
			Fields =
			{
				{ Name = "NoCursor", Type = "Cursormode", EnumValue = 0 },
				{ Name = "PointCursor", Type = "Cursormode", EnumValue = 1 },
				{ Name = "CastCursor", Type = "Cursormode", EnumValue = 2 },
				{ Name = "BuyCursor", Type = "Cursormode", EnumValue = 3 },
				{ Name = "AttackCursor", Type = "Cursormode", EnumValue = 4 },
				{ Name = "InteractCursor", Type = "Cursormode", EnumValue = 5 },
				{ Name = "SpeakCursor", Type = "Cursormode", EnumValue = 6 },
				{ Name = "InspectCursor", Type = "Cursormode", EnumValue = 7 },
				{ Name = "PickupCursor", Type = "Cursormode", EnumValue = 8 },
				{ Name = "TaxiCursor", Type = "Cursormode", EnumValue = 9 },
				{ Name = "TrainerCursor", Type = "Cursormode", EnumValue = 10 },
				{ Name = "MineCursor", Type = "Cursormode", EnumValue = 11 },
				{ Name = "SkinCursor", Type = "Cursormode", EnumValue = 12 },
				{ Name = "GatherCursor", Type = "Cursormode", EnumValue = 13 },
				{ Name = "LockCursor", Type = "Cursormode", EnumValue = 14 },
				{ Name = "MailCursor", Type = "Cursormode", EnumValue = 15 },
				{ Name = "LootAllCursor", Type = "Cursormode", EnumValue = 16 },
				{ Name = "RepairCursor", Type = "Cursormode", EnumValue = 17 },
				{ Name = "RepairnpcCursor", Type = "Cursormode", EnumValue = 18 },
				{ Name = "ItemCursor", Type = "Cursormode", EnumValue = 19 },
				{ Name = "SkinHordeCursor", Type = "Cursormode", EnumValue = 20 },
				{ Name = "SkinAllianceCursor", Type = "Cursormode", EnumValue = 21 },
				{ Name = "InnkeeperCursor", Type = "Cursormode", EnumValue = 22 },
				{ Name = "CampaignQuestCursor", Type = "Cursormode", EnumValue = 23 },
				{ Name = "CampaignQuestTurninCursor", Type = "Cursormode", EnumValue = 24 },
				{ Name = "QuestCursor", Type = "Cursormode", EnumValue = 25 },
				{ Name = "QuestRepeatableCursor", Type = "Cursormode", EnumValue = 26 },
				{ Name = "QuestTurninCursor", Type = "Cursormode", EnumValue = 27 },
				{ Name = "QuestLegendaryCursor", Type = "Cursormode", EnumValue = 28 },
				{ Name = "QuestLegendaryTurninCursor", Type = "Cursormode", EnumValue = 29 },
				{ Name = "VehicleCursor", Type = "Cursormode", EnumValue = 30 },
				{ Name = "MapPinCursor", Type = "Cursormode", EnumValue = 31 },
				{ Name = "UIMoveCursor", Type = "Cursormode", EnumValue = 32 },
				{ Name = "UIResizeCursor", Type = "Cursormode", EnumValue = 33 },
				{ Name = "PointErrorCursor", Type = "Cursormode", EnumValue = 34 },
				{ Name = "CastErrorCursor", Type = "Cursormode", EnumValue = 35 },
				{ Name = "BuyErrorCursor", Type = "Cursormode", EnumValue = 36 },
				{ Name = "AttackErrorCursor", Type = "Cursormode", EnumValue = 37 },
				{ Name = "InteractErrorCursor", Type = "Cursormode", EnumValue = 38 },
				{ Name = "SpeakErrorCursor", Type = "Cursormode", EnumValue = 39 },
				{ Name = "InspectErrorCursor", Type = "Cursormode", EnumValue = 40 },
				{ Name = "PickupErrorCursor", Type = "Cursormode", EnumValue = 41 },
				{ Name = "TaxiErrorCursor", Type = "Cursormode", EnumValue = 42 },
				{ Name = "TrainerErrorCursor", Type = "Cursormode", EnumValue = 43 },
				{ Name = "MineErrorCursor", Type = "Cursormode", EnumValue = 44 },
				{ Name = "SkinErrorCursor", Type = "Cursormode", EnumValue = 45 },
				{ Name = "GatherErrorCursor", Type = "Cursormode", EnumValue = 46 },
				{ Name = "LockErrorCursor", Type = "Cursormode", EnumValue = 47 },
				{ Name = "MailErrorCursor", Type = "Cursormode", EnumValue = 48 },
				{ Name = "LootAllErrorCursor", Type = "Cursormode", EnumValue = 49 },
				{ Name = "RepairErrorCursor", Type = "Cursormode", EnumValue = 50 },
				{ Name = "RepairnpcErrorCursor", Type = "Cursormode", EnumValue = 51 },
				{ Name = "ItemErrorCursor", Type = "Cursormode", EnumValue = 52 },
				{ Name = "SkinHordeErrorCursor", Type = "Cursormode", EnumValue = 53 },
				{ Name = "SkinAllianceErrorCursor", Type = "Cursormode", EnumValue = 54 },
				{ Name = "InnkeeperErrorCursor", Type = "Cursormode", EnumValue = 55 },
				{ Name = "CampaignQuestErrorCursor", Type = "Cursormode", EnumValue = 56 },
				{ Name = "CampaignQuestTurninErrorCursor", Type = "Cursormode", EnumValue = 57 },
				{ Name = "QuestErrorCursor", Type = "Cursormode", EnumValue = 58 },
				{ Name = "QuestRepeatableErrorCursor", Type = "Cursormode", EnumValue = 59 },
				{ Name = "QuestTurninErrorCursor", Type = "Cursormode", EnumValue = 60 },
				{ Name = "QuestLegendaryErrorCursor", Type = "Cursormode", EnumValue = 61 },
				{ Name = "QuestLegendaryTurninErrorCursor", Type = "Cursormode", EnumValue = 62 },
				{ Name = "VehicleErrorCursor", Type = "Cursormode", EnumValue = 63 },
				{ Name = "MapPinErrorCursor", Type = "Cursormode", EnumValue = 64 },
				{ Name = "CustomCursor", Type = "Cursormode", EnumValue = 65 },
			},
		},
	},
};

APIDocumentation:AddDocumentationTable(CursorConst);
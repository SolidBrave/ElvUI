local SLE, T, E, L, V, P, G = unpack(select(2, ...))
--GLOBALS: SLE_ArmoryDB
local _
local _G = _G
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

if not (select(2, GetAddOnInfo('ElvUI_KnightFrame')) and IsAddOnLoaded('ElvUI_KnightFrame')) then
	--<< INITIALIZE >>--
	local AddOnName, Engine = 'ElvUI_KnightFrame', {}
	local Info = {
		Name = 'KnightFrame',
		MyRealm = gsub(E.myrealm,'[%s%-]','')
	}
	local KF = SLE:NewModule(Info.Name, 'AceEvent-3.0', 'AceConsole-3.0', 'AceHook-3.0')
	KF.Modules = {}
	
	
	--<< TOOLKIT >>--
	function KF:Color_Value(InputText)
		return E:RGBToHex(E.media.rgbvaluecolor[1], E.media.rgbvaluecolor[2], E.media.rgbvaluecolor[3])..(InputText and InputText..'|r' or '')
	end	
	
	function KF:Color_Class(Class, InputText)
		return (Class and '|c'..RAID_CLASS_COLORS[Class].colorStr or '')..(InputText and InputText..'|r' or '')
	end
	
	function KF:TextSetting(self, Text, Style, ...)
		if Style and Style.Tag then
			self[Style.Tag] = self[Style.Tag] or self:CreateFontString(nil, 'OVERLAY')
			self = self[Style.Tag]
		else
			Style = Style or {}
			self.text = self.text or self:CreateFontString(nil, 'OVERLAY')
			self = self.text
		end
		
		self:FontTemplate(Style.Font and E.LSM:Fetch('font', Style.Font), Style.FontSize, Style.FontStyle)
		self:SetJustifyH(Style.directionH or 'CENTER')
		self:SetJustifyV(Style.directionV or 'MIDDLE')
		self:SetText(Text)
		
		if ... then
			self:Point(...)
		else
			self:SetInside()
		end
	end
	
	
	--<< GLOBALSTRINGS >>--
	for ClassName, SpecializationIDTable in pairs({
		Warrior = {
			Arms = 71,
			Fury = 72,
			Protection = 73
		},
		Hunter = {
			Beast = 253,
			Marksmanship = 254,
			Survival = 255
		},
		Shaman = {
			Elemental = 262,
			Enhancement = 263,
			Restoration = 264
		},
		Monk = {
			Brewmaster = 268,
			Mistweaver = 270,
			Windwalker = 269
		},
		Rogue = {
			Assassination = 259,
			Combat = 260,
			Subtlety = 261
		},
		DeathKnight = {
			Blood = 250,
			Frost = 251,
			Unholy = 252
		},
		DemonHunter = {
			Havoc = 577,
			Vengeance = 581,
		},
		Mage = {
			Arcane = 62,
			Fire = 63,
			Frost = 64
		},
		Druid = {
			Balance = 102,
			Feral = 103,
			Guardian = 104,
			Restoration = 105
		},
		Paladin = {
			Holy = 65,
			Protection = 66,
			Retribution = 70
		},
		Priest = {
			Discipline = 256,
			Holy = 257,
			Shadow = 258
		},
		Warlock = {
			Affliction = 265,
			Demonology = 266,
			Destruction = 267
		}
	}) do
		L[ClassName] = KF:Color_Class(string.upper(ClassName), LOCALIZED_CLASS_NAMES_MALE[string.upper(ClassName)])
		
		for Name, ID in pairs(SpecializationIDTable) do
			_, L["Spec_"..ClassName.."_"..Name] = GetSpecializationInfoByID(ID)
		end
	end
	
	Info.ClassRole = {
		WARRIOR = {
			[(L["Spec_Warrior_Arms"])] = { --??????
				Color = '|cff9a9a9a',
				Role = 'Melee'
			},
			[(L["Spec_Warrior_Fury"])] = { --??????
				Color = '|cffb50000',
				Role = 'Melee'
			},
			[(L["Spec_Warrior_Protection"])] = { --??????
				Color = '|cff088fdc',
				Role = 'Tank'
			}
		},
		HUNTER = {
			[(L["Spec_Hunter_Beast"])] = { --??????
				Color = '|cffffdb00',
				Role = 'Melee'
			},
			[(L["Spec_Hunter_Marksmanship"])] = { --??????
				Color = '|cffea5455',
				Role = 'Melee'
			},
			[(L["Spec_Hunter_Survival"])] = { --??????
				Color = '|cffbaf71d',
				Role = 'Melee'
			}
		},
		SHAMAN = {
			[(L["Spec_Shaman_Elemental"])] = { --??????
				Color = '|cff2be5fa',
				Role = 'Caster'
			},
			[(L["Spec_Shaman_Enhancement"])] = { --??????
				Color = '|cffe60000',
				Role = 'Melee'
			},
			[(L["Spec_Shaman_Restoration"])] = { --??????
				Color = '|cff00ff0c',
				Role = 'Healer'
			}
		},
		MONK = {
			[(L["Spec_Monk_Brewmaster"])] = { --??????
				Color = '|cffbcae6d',
				Role = 'Tank'
			},
			[(L["Spec_Monk_Mistweaver"])] = { --??????
				Color = '|cffb6f1b7',
				Role = 'Healer'
			},
			[(L["Spec_Monk_Windwalker"])] = { --??????
				Color = '|cffb2c6de',
				Role = 'Melee'
			}
		},
		ROGUE = {
			[(L["Spec_Rogue_Assassination"])] = { --??????
				Color = '|cff129800',
				Role = 'Melee'
			},
			[(L["Spec_Rogue_Combat"])] = { --??????
				Color = '|cffbc0001',
				Role = 'Melee'
			},
			[(L["Spec_Rogue_Subtlety"])] = { --??????
				Color = '|cfff48cba',
				Role = 'Melee'
			}
		},
		DEATHKNIGHT = {
			[(L["Spec_DeathKnight_Blood"])] = { --??????
				Color = '|cffbc0001',
				Role = 'Tank'
			},
			[(L["Spec_DeathKnight_Frost"])] = { --??????
				Color = '|cff1784d1',
				Role = 'Melee'
			},
			[(L["Spec_DeathKnight_Unholy"])] = { --??????
				Color = '|cff00ff10',
				Role = 'Melee'
			}
		},
		DEMONHUNTER = {
			[(L["Spec_DemonHunter_Havoc"])] = { 
				Color = '|cffa330c9',
				Role = 'Melee'
			},
			[(L["Spec_DemonHunter_Vengeance"])] = {
				Color = '|cffa330c9',
				Role = 'Tank'
			},
		},
		MAGE = {
			[(L["Spec_Mage_Arcane"])] = { --??????
				Color = '|cffdcb0fb',
				Role = 'Caster'
			},
			[(L["Spec_Mage_Fire"])] = { --??????
				Color = '|cffff3615',
				Role = 'Caster'
			},
			[(L["Spec_Mage_Frost"])] = { --??????
				Color = '|cff1784d1',
				Role = 'Caster'
			}
		},
		DRUID = {
			[(L["Spec_Druid_Balance"])] = { --??????
				Color = '|cffff7d0a',
				Role = 'Caster'
			},
			[(L["Spec_Druid_Feral"])] = { --??????
				Color = '|cffffdb00',
				Role = 'Melee'
			},
			[(L["Spec_Druid_Guardian"])] = { --??????
				Color = '|cff088fdc',
				Role = 'Tank'
			},
			[(L["Spec_Druid_Restoration"])] = { --??????
				Color = '|cff64df62',
				Role = 'Healer'
			}
		},
		PALADIN = {
			[(L["Spec_Paladin_Holy"])] = { --??????
				Color = '|cfff48cba',
				Role = 'Healer'
			},		
			[(L["Spec_Paladin_Protection"])] = { --??????
				Color = '|cff84e1ff',
				Role = 'Tank'
			},
			[(L["Spec_Paladin_Retribution"])] = { --??????
				Color = '|cffe60000',
				Role = 'Melee'
			}
		},
		PRIEST = {
			[(L["Spec_Priest_Discipline"])] = { --??????
				Color = '|cffffffff',
				Role = 'Healer'
			},
			[(L["Spec_Priest_Holy"])] = { --??????
				Color = '|cff6bdaff',
				Role = 'Healer'
			},
			[(L["Spec_Priest_Shadow"])] = { --??????
				Color = '|cff7e52c1',
				Role = 'Caster'
			}
		},
		WARLOCK = {
			[(L["Spec_Warlock_Affliction"])] = { --??????
				Color = '|cff00ff10',
				Role = 'Caster'
			},
			[(L["Spec_Warlock_Demonology"])] = { --??????
				Color = '|cff9482c9',
				Role = 'Caster'
			},
			[(L["Spec_Warlock_Destruction"])] = { --??????
				Color = '|cffba1706',
				Role = 'Caster'
			}
		}
	}
	
	
	local Timer = {}
	
	Engine[1] = KF
	Engine[2] = Info
	Engine[3] = Timer
	
	_G[AddOnName] = Engine
	
	if type(SLE_ArmoryDB) ~= 'table' then
		SLE_ArmoryDB = {
			EnchantString = {}
		}
	end
	
	function KF:Credit()
		return KF:Color_Value('Created By')..' |cffffffffArstraea|r |cffceff00(kr)|r'
	end
	
	function KF:Initialize()
		for i = 1, #KF.Modules do
			KF.Modules[(KF.Modules[i])]()
		end
		
		function KF:ForUpdateAll()
			_G["CharacterArmory"]:UpdateSettings("all")
			if not SLE._Compatibility["DejaCharacterStats"] then
				_G["CharacterArmory"]:ToggleStats()
				_G["CharacterArmory"]:UpdateIlvlFont()
			end
			_G["InspectArmory"]:UpdateSettings("all")
		end
	end
	SLE:RegisterModule(KF:GetName())
end

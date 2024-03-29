----------------------------------------------------------------------------------------------------
local PTR_Event_Frame = CreateFrame("Frame")

PTR_IssueReporter.InBarbershop = false

PTR_IssueReporter.ReportEventTypes = {
    Tooltip = "Tooltip",
    MapIDEnter = "MapIDEnter",
    MapIDExit = "MapIDExit",
    MapDifficultyIDStarted = "MapDifficultyIDStarted",
    MapDifficultyIDEnded = "MapDifficultyIDEnded",    
    UIButtonClicked = "UIButtonClicked",
    QuestFrameClosed = "QuestFrameClosed",
    QuestRewardFrameShown = "QuestRewardFrameShown",
    QuestTurnedIn = "QuestTurnedIn",
    BarberShopOpened = "BarberShopOpened",
    BarberShopClosed = "BarberShopClosed",
}
----------------------------------------------------------------------------------------------------
local function QuestCompleteHandler()
    PTR_IssueReporter.TriggerEvent(PTR_IssueReporter.ReportEventTypes.QuestRewardFrameShown, questID, {ID = GetQuestID()})
end
----------------------------------------------------------------------------------------------------
local function QuestTurnedInHandler(...)
    local questID = ...
    PTR_IssueReporter.TriggerEvent(PTR_IssueReporter.ReportEventTypes.QuestTurnedIn, questID, {ID = questID})
end
----------------------------------------------------------------------------------------------------
local function QuestFinishedHandler()
    PTR_IssueReporter.TriggerEvent(PTR_IssueReporter.ReportEventTypes.QuestFrameClosed)
end    
----------------------------------------------------------------------------------------------------
local function BarberShopOpenedHandler()
    PTR_IssueReporter.TriggerEvent(PTR_IssueReporter.ReportEventTypes.BarberShopOpened)
    PTR_IssueReporter:SetParent(CharCustomizeFrame)
    PTR_IssueReporter:SetFrameStrata("DIALOG")
	PTR_IssueReporter.InBarbershop = true
end
----------------------------------------------------------------------------------------------------
local function BarberShopClosedHandler()
    PTR_IssueReporter.TriggerEvent(PTR_IssueReporter.ReportEventTypes.BarberShopClosed)
    PTR_IssueReporter:SetParent(GetAppropriateTopLevelParent())
	PTR_IssueReporter:SetFrameStrata("DIALOG")
    PTR_IssueReporter.InBarbershop = false
end
----------------------------------------------------------------------------------------------------
PTR_IssueReporter.Data.RegisteredEvents = 
{
    ZONE_CHANGED = PTR_IssueReporter.HandleMapEvents,
    ZONE_CHANGED_INDOORS = PTR_IssueReporter.HandleMapEvents,
    ZONE_CHANGED_NEW_AREA = PTR_IssueReporter.HandleMapEvents,
    QUEST_COMPLETE = QuestCompleteHandler,
    QUEST_TURNED_IN = QuestTurnedInHandler,
    QUEST_FINISHED = QuestFinishedHandler,
    PLAYER_REGEN_ENABLED = PTR_IssueReporter.CheckSurveyQueue,
    BARBER_SHOP_OPEN = BarberShopOpenedHandler,
    BARBER_SHOP_CLOSE = BarberShopClosedHandler,
}
for event, func in pairs (PTR_IssueReporter.Data.RegisteredEvents) do
    PTR_Event_Frame:RegisterEvent(event)
end
----------------------------------------------------------------------------------------------------
local function PTR_Event_Frame_OnEvent(self, event, ...)
    if (PTR_IssueReporter.Data.IsLoaded) or (event == "PLAYER_ENTERING_WORLD") then
        local eventFunction = PTR_IssueReporter.Data.RegisteredEvents[event]
        if (eventFunction) and (type(eventFunction) == "function") then
            eventFunction(...)
        end
    end
end
PTR_Event_Frame:SetScript("OnEvent", PTR_Event_Frame_OnEvent)
----------------------------------------------------------------------------------------------------
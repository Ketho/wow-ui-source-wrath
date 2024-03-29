---------------
--NOTE - Please do not change this section without talking to the UI team
local _, tbl = ...;
if tbl then
	tbl.SecureCapsuleGet = SecureCapsuleGet;

	local function Import(name)
		tbl[name] = tbl.SecureCapsuleGet(name);
	end

	Import("IsOnGlueScreen");

	if ( tbl.IsOnGlueScreen() ) then
		tbl._G = _G;	--Allow us to explicitly access the global environment at the glue screens
	end

	setfenv(1, tbl);

Import("table");
Import("select");
Import("ipairs");
Import("math");

end
---------------

DataProviderMixin = CreateFromMixins(CallbackRegistryMixin);

DataProviderMixin:GenerateCallbackEvents(
	{
		"OnSizeChanged",
		"OnInsert",
		"OnRemove",
		"OnSort",
	}
);

function DataProviderMixin:Init(tbl)
	CallbackRegistryMixin.OnLoad(self);
	
	self.collection = {};

	if tbl then
		self:InsertTable(tbl);
	end
end

function DataProviderMixin:Enumerate(minIndex, maxIndex)
	return CreateTableEnumerator(self.collection, minIndex, maxIndex);
end

function DataProviderMixin:ReverseEnumerate(minIndex, maxIndex)
	return CreateTableReverseEnumerator(self.collection, minIndex, maxIndex);
end

function DataProviderMixin:GetCollection()
	return self.collection;
end

function DataProviderMixin:GetSize()
	return #self.collection;
end

function DataProviderMixin:IsEmpty()
	return self:GetSize() == 0;
end

function DataProviderMixin:InsertInternal(elementData, hasSortComparator)
	table.insert(self.collection, elementData);
	local insertIndex = #self.collection;
	self:TriggerEvent(DataProviderMixin.Event.OnInsert, insertIndex, elementData, hasSortComparator);
end

function DataProviderMixin:Insert(...)
	local hasSortComparator = self:HasSortComparator();
	local count = select("#", ...);
	for index = 1, count do
		self:InsertInternal(select(index, ...), hasSortComparator);
	end

	if count > 0 then
		self:TriggerEvent(DataProviderMixin.Event.OnSizeChanged, hasSortComparator);
	end

	self:Sort();
end

function DataProviderMixin:InsertTable(tbl)
	self:InsertTableRange(tbl, 1, #tbl);
end

function DataProviderMixin:InsertTableRange(tbl, minIndex, maxIndex)
	if maxIndex - minIndex < 0 then
		return;
	end

	local hasSortComparator = self:HasSortComparator();
	for index = minIndex, maxIndex do
		self:InsertInternal(tbl[index], hasSortComparator);
	end

	self:TriggerEvent(DataProviderMixin.Event.OnSizeChanged, hasSortComparator);

	self:Sort();
end

function DataProviderMixin:Remove(...)
	local removedIndex = nil;
	local originalSize = self:GetSize();
	local count = select("#", ...);
	while count >= 1 do
		local elementData = select(count, ...);
		local index = tIndexOf(self.collection, elementData);
		if index then
			table.remove(self.collection, index);
			self:TriggerEvent(DataProviderMixin.Event.OnRemove, elementData, index);
			removedIndex = index;
		end
		count = count - 1;
	end

	if self:GetSize() ~= originalSize then
		local sorting = false;
		self:TriggerEvent(DataProviderMixin.Event.OnSizeChanged, sorting);
	end

	return removedIndex;
end

function DataProviderMixin:RemoveByPredicate(predicate)
	local index, elementData = self:FindByPredicate(predicate);
	if elementData then
		self:Remove(elementData);
	end
end

function DataProviderMixin:RemoveIndex(index)
	self:RemoveIndexRange(index, index);
end

function DataProviderMixin:RemoveIndexRange(minIndex, maxIndex)
	local originalSize = self:GetSize();

	minIndex = math.max(1, minIndex);
	maxIndex = math.min(self:GetSize(), maxIndex);
	while maxIndex >= minIndex do
		local elementData = self.collection[maxIndex];
		table.remove(self.collection, maxIndex);
		self:TriggerEvent(DataProviderMixin.Event.OnRemove, elementData, maxIndex);
		maxIndex = maxIndex - 1;
	end

	if self:GetSize() ~= originalSize then
		local sorting = false;
		self:TriggerEvent(DataProviderMixin.Event.OnSizeChanged, sorting);
	end
end


function DataProviderMixin:SetSortComparator(sortComparator, skipSort)
	self.sortComparator = sortComparator;
	if not skipSort then
		self:Sort();
	end
end

function DataProviderMixin:ClearSortComparator()
	self.sortComparator = nil;
end

function DataProviderMixin:HasSortComparator()
	return self.sortComparator ~= nil;
end

function DataProviderMixin:Sort()
	if self.sortComparator then
		table.sort(self.collection, self.sortComparator);
		self:TriggerEvent(DataProviderMixin.Event.OnSort);
	end
end

function DataProviderMixin:Find(index)
	return self.collection[index];
end

function DataProviderMixin:FindIndex(elementData)
	for index, elementDataIter in self:Enumerate() do
		if elementDataIter == elementData then
			return index, elementDataIter;
		end
	end
end

function DataProviderMixin:FindByPredicate(predicate)
	for index, elementData in self:Enumerate() do
		if predicate(elementData) then
			return index, elementData;
		end
	end
end

function DataProviderMixin:FindElementDataByPredicate(predicate)
	local index, elementData = self:FindByPredicate(predicate);
	return elementData;
end

function DataProviderMixin:FindIndexByPredicate(predicate)
	local index, elementData = self:FindByPredicate(predicate);
	return index;
end

function DataProviderMixin:ContainsByPredicate(predicate)
	local index, elementData = self:FindByPredicate(predicate);
	return index ~= nil;
end

function DataProviderMixin:ForEach(func)
	for index, elementData in self:Enumerate() do
		func(elementData);
	end
end

function DataProviderMixin:ReverseForEach(func)
	for index, elementData in self:ReverseEnumerate() do
		func(elementData);
	end
end

function DataProviderMixin:Flush()
	local oldCollection = self.collection;
	self.collection = {};
	for index, elementData in ipairs(oldCollection) do
		self:TriggerEvent(DataProviderMixin.Event.OnRemove, elementData, index);
	end
	local sorting = false;
	self:TriggerEvent(DataProviderMixin.Event.OnSizeChanged, sorting);
end

function CreateDataProvider(tbl)
	local dataProvider = CreateFromMixins(DataProviderMixin);
	dataProvider:Init(tbl);
	return dataProvider;
end

local function CreateDefaultIndicesTable(indexCount)
	local tbl = {};
	for index = 1, indexCount do
		table.insert(tbl, {index = index});
	end
	return tbl;
end

function CreateDataProviderByIndexCount(indexCount)
	return CreateDataProvider(CreateDefaultIndicesTable(indexCount));
end

function CreateDataProviderWithAssignedKey(tbl, key)
	local dataProvider = CreateDataProvider();
	for index, value in ipairs(tbl) do
		dataProvider:Insert({[key]=value});
	end
	return dataProvider;
end
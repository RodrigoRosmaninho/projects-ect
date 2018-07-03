import pytest
from Sound import get_highest, linear, branch, ef_fade, ef_reverse, ef_echo, ef_volume

def test_get_highest():
	data1=[[0,0,0],[0],[0,0]]
	assert get_highest(data1)==3
	data2=[[0,0],[0,0]]
	assert get_highest(data2)==2

def test_linear():
	assert linear(0,10,0,6)==0
	assert linear(10,10,0,6)==6
	assert linear(5,10,0,6)==3
	assert linear(0,10,6,0)==6
	assert linear(10,10,6,0)==0
	assert linear(5,10,6,0)==3

def test_branch():
	for i in range(0,5):
		assert round(branch(i,10,0,1))==round(branch(10-i,10,0,1))

def test_fade():
	assert ef_fade([10,10,10],"noeffect") == [10,10,10]

def test_reverse():
	assert ef_reverse([1,2,3])==[3,2,1]
	assert ef_reverse([0,0,0])==[0,0,0]
	assert ef_reverse([1,2,1])==[1,2,1]

def test_echo():
	assert len(ef_echo([1,1,1,1]))==6

def test_volume():
	assert ef_volume([0,0,0],5)==[0,0,0]
	assert ef_volume([1,2,3],2)==[2,4,6]

# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(grid, k):
    n = len(grid)
    minNum = 0
    for i in range(n):
        for j in range(n):
            if grid[i][j] == 1:
                tmp = []
                if i != 0:
                    tmp.append(grid[i-1][j])
                if j != 0:
                    tmp.append(grid[i][j-1])
                if i != n - 1:
                    tmp.append(grid[i+1][j])
                if j != n - 1:
                    tmp.append(grid[i][j+1])
                minNum = min(tmp)
    ans = []
    for i in range(k):
        if i % 2 == 0:
            ans.append(1)
        else:
            ans.append(minNum)
    return ans

# End here


def serialize_list(obj) -> str:
    list_str = ["["]
    for item in obj:
        list_str.append(serialize_obj(item))
        list_str.append(",")
    list_str[-1] = "]"
    return "".join(list_str)


def serialize_dict(obj) -> str:
    m = OrderedDict(sorted(obj.items()))
    dict_str = ["{"]
    for key, value in m.items():
        dict_str.append(serialize_obj(key))
        dict_str.append(":")
        dict_str.append(serialize_obj(value))
        dict_str.append(",")
    dict_str[-1] = "}"
    return "".join(dict_str)


def serialize_obj(obj) -> str:
    if obj is None:
        return "null"
    if isinstance(obj, int) or isinstance(obj, float):
        return "{0:.6f}".format(obj)
    if isinstance(obj, str):
        return '"' + obj + '"'
    if isinstance(obj, bool):
        return str(obj)
    if isinstance(obj, list):
        return serialize_list(obj)
    if isinstance(obj, dict):
        return serialize_dict(obj)
    raise Exception("Unrecognized Type!")


def are_equivalent(o1, o2) -> bool:
    print(serialize_obj(o1)+" "+serialize_obj(o2))
    return serialize_obj(o1) == serialize_obj(o2)


def start():
    ret = False
    count = 0
    total = 0
    # Write the unit tests here
    total += 1
    ret = are_equivalent(testfunc([[1,2,3],[4,5,6],[7,8,9]],3),[1,2,1])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([[5,9,3],[4,1,6],[7,8,2]],1),[1])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]],4),[1,2,1,2])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([[2,7,4],[3,1,5],[6,8,9]],8),[1,3,1,3,1,3,1,3])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([[1,2],[3,4]],10),[1,2,1,2,1,2,1,2,1,2])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()

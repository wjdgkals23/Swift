extension String {
    func myIndexOf(_ pattern:String) -> String.Index? {
        for i in self.indices {
            var j = i
            var found:Bool = true
            for c in pattern.indices {
                if(j == self.endIndex || pattern[c] != self[j]) {
                    found = false
                    break
                } else {
                    j = self.index(after: j)
                }
                if found {
                    return i
                }
            }
        }
        return nil
    }
}

var temp:String = "abcdefgbbbhi"
var bb_ind = temp.myIndexOf("bbb")
print(temp[...bb_ind!])



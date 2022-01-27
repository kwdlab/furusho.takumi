(*
  NewVotingSystem.sol

  Created by Takumi Furusho on 2022/01/24
  Copyright (c) 2022 Takumi Furusho
*)

pragma solidity ^0.8.11;

contract NewVoting {

    //学生ストラクト
    struct Student {
        bool Orvoted; //投票したかどうか trueなら3回投票済み 初期値はfalse
        uint Weight; //投票回数 初期値は0
        string VoteName; //投票先の候補者名
    }

    //学生マッピング
    mapping(address => Student) public students;

    //教師
    address public teacher;

    //候補者ストラクト
    struct Candidate {
        uint VotesReceived; //候補者の得票数
        string Name; //候補者の名前
    }

    //候補者リストマッピング
    Candidate[] public CandidateList;  //構造体型の候補者リスト

    function CandidateFactory() public { //候補者を登録
         //具体的な名前　得票数は初期値として0を与える
        CandidateList.push(Candidate(0, "Sato")); //リストに追加していく
        CandidateList.push(Candidate(0, "Takahashi"));
        CandidateList.push(Candidate(0, "Okamoto"));
        CandidateList.push(Candidate(0, "Tani"));
        CandidateList.push(Candidate(0, "Nakamura"));
        CandidateList.push(Candidate(0, "Tanaka"));
        CandidateList.push(Candidate(0, "Kato"));
        CandidateList.push(Candidate(0, "Matsumoto"));
        CandidateList.push(Candidate(0, "Ito"));
        CandidateList.push(Candidate(0, "Yamashita"));
    }


    //コンストラクタ
    function Vote() public {
        teacher = msg.sender; //教師を設定
    }

    //教師が学生に投票権を与える
    function GiveRight(address student) public {
        require((msg.sender == teacher) && !students[student].Orvoted); //教師であることかつ学生が未投票であること
        students[student].Weight = 3; //投票権は1人3票
    }

    //候補者名を記述して投票する 　　その後、得票数を昇順に並び替える
    function VoteForCandidate() public {  
        address student1; //投票者1人目
        GiveRight(student1); //投票権を受け取る
        //1回目の投票
        students[student1].VoteName = "Takahashi";
        require(ValidCandidate(student1)); //候補者リストにある名前かどうかチェック
        Remove("Takahashi"); //投票した候補者をリストから消す

        //2回目の投票
        students[student1].VoteName = "Tani"; //上記の繰り返し
        require(ValidCandidate(student1));
        Remove("Tani");

        //3回目の投票
        students[student1].VoteName = "Sato";
        require(ValidCandidate(student1));
        Remove("Sato");

        CandidateList.push(Candidate(1, "Takahashi")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(1, "Tani"));
        CandidateList.push(Candidate(1, "Sato"));
        students[student1].Orvoted = true; //投票完了

        address student2; //投票者2人目
        GiveRight(student2); //投票権を受け取る
        //1回目の投票
        students[student2].VoteName = "Yamashita";
        require(ValidCandidate(student2)); //候補者リストにある名前かどうかチェック
        Remove("Yamashita"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student2].VoteName = "Ito"; //上記の繰り返し
        require(ValidCandidate(student2));
        Remove("Ito");

        //3回目の投票
        students[student2].VoteName = "Sato";
        require(ValidCandidate(student2));
        Remove("Sato");

        CandidateList.push(Candidate(1, "Yamashita")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(1, "Ito"));
        CandidateList.push(Candidate(2, "Sato"));
        students[student2].Orvoted = true; //投票完了

        address student3; //投票者3人目
        GiveRight(student3); //投票権を受け取る
        //1回目の投票
        students[student3].VoteName = "Tani";
        require(ValidCandidate(student3)); //候補者リストにある名前かどうかチェック
        Remove("Tani"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student3].VoteName = "Yamashita"; //上記の繰り返し
        require(ValidCandidate(student3));
        Remove("Yamashita");

        //3回目の投票
        students[student3].VoteName = "Takahashi";
        require(ValidCandidate(student3));
        Remove("Takahashi");

        CandidateList.push(Candidate(2, "Tani")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(2, "Yamashita"));
        CandidateList.push(Candidate(2, "Takahashi"));
        students[student3].Orvoted = true; //投票完了

        address student4; //投票者4人目
        GiveRight(student4); //投票権を受け取る
        //1回目の投票
        students[student4].VoteName = "Ito";
        require(ValidCandidate(student4)); //候補者リストにある名前かどうかチェック
        Remove("Ito"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student4].VoteName = "Tani"; //上記の繰り返し
        require(ValidCandidate(student4));
        Remove("Tani");

        //3回目の投票
        students[student4].VoteName = "Sato";
        require(ValidCandidate(student4));
        Remove("Sato");

        CandidateList.push(Candidate(2, "Ito")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(3, "Tani"));
        CandidateList.push(Candidate(3, "Sato"));
        students[student4].Orvoted = true; //投票完了

        address student5; //投票者5人目
        GiveRight(student5); //投票権を受け取る
        //1回目の投票
        students[student5].VoteName = "Nakamura";
        require(ValidCandidate(student5)); //候補者リストにある名前かどうかチェック
        Remove("Nakamura"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student5].VoteName = "Ito"; //上記の繰り返し
        require(ValidCandidate(student5));
        Remove("Ito");

        //3回目の投票
        students[student5].VoteName = "Matsumoto";
        require(ValidCandidate(student5));
        Remove("Matsumoto");

        CandidateList.push(Candidate(1, "Nakamura")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(3, "Ito"));
        CandidateList.push(Candidate(1, "Matsumoto"));
        students[student5].Orvoted = true; //投票完了

        address student6; //投票者6人目
        GiveRight(student6); //投票権を受け取る
        //1回目の投票
        students[student6].VoteName = "Tanaka";
        require(ValidCandidate(student6)); //候補者リストにある名前かどうかチェック
        Remove("Tanaka"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student6].VoteName = "Sato"; //上記の繰り返し
        require(ValidCandidate(student6));
        Remove("Sato");

        //3回目の投票
        students[student6].VoteName = "Matsumoto";
        require(ValidCandidate(student6));
        Remove("Matsumoto");

        CandidateList.push(Candidate(1, "Tanaka")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(4, "Sato"));
        CandidateList.push(Candidate(2, "Matsumoto"));
        students[student6].Orvoted = true; //投票完了

        address student7; //投票者7人目
        GiveRight(student7); //投票権を受け取る
        //1回目の投票
        students[student7].VoteName = "Ito";
        require(ValidCandidate(student7)); //候補者リストにある名前かどうかチェック
        Remove("Ito"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student7].VoteName = "Matsumoto"; //上記の繰り返し
        require(ValidCandidate(student7));
        Remove("Matsumoto");

        //3回目の投票
        students[student7].VoteName = "Okamoto";
        require(ValidCandidate(student7));
        Remove("Okamoto");

        CandidateList.push(Candidate(4, "Ito")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(3, "Matsumoto"));
        CandidateList.push(Candidate(1, "Okamoto"));
        students[student7].Orvoted = true; //投票完了

        address student8; //投票者8人目
        GiveRight(student8); //投票権を受け取る
        //1回目の投票
        students[student8].VoteName = "Ito";
        require(ValidCandidate(student8)); //候補者リストにある名前かどうかチェック
        Remove("Ito"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student8].VoteName = "Tanaka"; //上記の繰り返し
        require(ValidCandidate(student8));
        Remove("Tanaka");

        //3回目の投票
        students[student8].VoteName = "Okamoto";
        require(ValidCandidate(student8));
        Remove("Okamoto");

        CandidateList.push(Candidate(5, "Ito")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(2, "Tanaka"));
        CandidateList.push(Candidate(2, "Okamoto"));
        students[student8].Orvoted = true; //投票完了

        address student9; //投票者9人目
        GiveRight(student9); //投票権を受け取る
        //1回目の投票
        students[student9].VoteName = "Yamashita";
        require(ValidCandidate(student9)); //候補者リストにある名前かどうかチェック
        Remove("Yamashita"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student9].VoteName = "Sato"; //上記の繰り返し
        require(ValidCandidate(student9));
        Remove("Sato");

        //3回目の投票
        students[student9].VoteName = "Tani";
        require(ValidCandidate(student9));
        Remove("Tani");

        CandidateList.push(Candidate(3, "Yamashita")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(5, "Sato"));
        CandidateList.push(Candidate(4, "Tani"));
        students[student9].Orvoted = true; //投票完了


        address student10; //投票者10人目
        GiveRight(student10); //投票権を受け取る
        //1回目の投票
        students[student10].VoteName = "Yamashita";
        require(ValidCandidate(student10)); //候補者リストにある名前かどうかチェック
        Remove("Yamashita"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student10].VoteName = "Kato"; //上記の繰り返し
        require(ValidCandidate(student10));
        Remove("Kato");

        //3回目の投票
        students[student10].VoteName = "Ito";
        require(ValidCandidate(student10));
        Remove("Ito");

        CandidateList.push(Candidate(4, "Yamashita")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(1, "Kato"));
        CandidateList.push(Candidate(6, "Ito"));
        students[student10].Orvoted = true; //投票完了

        address student11; //投票者11人目
        GiveRight(student11); //投票権を受け取る
        //1回目の投票
        students[student11].VoteName = "Takahashi";
        require(ValidCandidate(student11)); //候補者リストにある名前かどうかチェック
        Remove("Takahashi"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student11].VoteName = "Kato"; //上記の繰り返し
        require(ValidCandidate(student11));
        Remove("Kato");

        //3回目の投票
        students[student11].VoteName = "Nakamura";
        require(ValidCandidate(student11));
        Remove("Nakamura");

        CandidateList.push(Candidate(3, "Takahashi")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(2, "Kato"));
        CandidateList.push(Candidate(2, "Nakamura"));
        students[student11].Orvoted = true; //投票完了

        address student12; //投票者12人目
        GiveRight(student12); //投票権を受け取る
        //1回目の投票
        students[student12].VoteName = "Sato";
        require(ValidCandidate(student12)); //候補者リストにある名前かどうかチェック
        Remove("Sato"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student12].VoteName = "Okamoto"; //上記の繰り返し
        require(ValidCandidate(student12));
        Remove("Okamoto");

        //3回目の投票
        students[student12].VoteName = "Tani";
        require(ValidCandidate(student12));
        Remove("Tani");

        CandidateList.push(Candidate(6, "Sato")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(3, "Okamoto"));
        CandidateList.push(Candidate(5, "Tani"));
        students[student12].Orvoted = true; //投票完了

        address student13; //投票者13人目
        GiveRight(student13); //投票権を受け取る
        //1回目の投票
        students[student13].VoteName = "Tanaka";
        require(ValidCandidate(student13)); //候補者リストにある名前かどうかチェック
        Remove("Tanaka"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student13].VoteName = "Kato"; //上記の繰り返し
        require(ValidCandidate(student13));
        Remove("Kato");

        //3回目の投票
        students[student13].VoteName = "Matsumoto";
        require(ValidCandidate(student13));
        Remove("Matsumoto");

        CandidateList.push(Candidate(3, "Tanaka")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(3, "Kato"));
        CandidateList.push(Candidate(4, "Matsumoto"));
        students[student13].Orvoted = true; //投票完了

        address student14; //投票者14人目
        GiveRight(student14); //投票権を受け取る
        //1回目の投票
        students[student14].VoteName = "Nakamura";
        require(ValidCandidate(student14)); //候補者リストにある名前かどうかチェック
        Remove("Nakamura"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student14].VoteName = "Ito"; //上記の繰り返し
        require(ValidCandidate(student14));
        Remove("Ito");

        //3回目の投票
        students[student14].VoteName = "Takahashi";
        require(ValidCandidate(student14));
        Remove("Takahashi");

        CandidateList.push(Candidate(3, "Nakamura")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(7, "Ito"));
        CandidateList.push(Candidate(5, "Takahashi"));
        students[student14].Orvoted = true; //投票完了

        address student15; //投票者15人目
        GiveRight(student15); //投票権を受け取る
        //1回目の投票
        students[student15].VoteName = "Tanaka";
        require(ValidCandidate(student15)); //候補者リストにある名前かどうかチェック
        Remove("Tanaka"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student15].VoteName = "Sato"; //上記の繰り返し
        require(ValidCandidate(student15));
        Remove("Sato");

        //3回目の投票
        students[student15].VoteName = "Matsumoto";
        require(ValidCandidate(student15));
        Remove("Matsumoto");

        CandidateList.push(Candidate(4, "Tanaka")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(7, "Sato"));
        CandidateList.push(Candidate(5, "Matsumoto"));
        students[student15].Orvoted = true; //投票完了

        address student16; //投票者16人目
        GiveRight(student16); //投票権を受け取る
        //1回目の投票
        students[student16].VoteName = "Nakamura";
        require(ValidCandidate(student16)); //候補者リストにある名前かどうかチェック
        Remove("Nakamura"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student16].VoteName = "Kato"; //上記の繰り返し
        require(ValidCandidate(student16));
        Remove("Kato");

        //3回目の投票
        students[student16].VoteName = "Yamashita";
        require(ValidCandidate(student16));
        Remove("Yamashita");

        CandidateList.push(Candidate(4, "Nakamura")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(4, "Kato"));
        CandidateList.push(Candidate(5, "Yamashita"));
        students[student16].Orvoted = true; //投票完了

        address student17; //投票者17人目
        GiveRight(student17); //投票権を受け取る
        //1回目の投票
        students[student17].VoteName = "Okamoto";
        require(ValidCandidate(student17)); //候補者リストにある名前かどうかチェック
        Remove("Okamoto"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student17].VoteName = "Ito"; //上記の繰り返し
        require(ValidCandidate(student17));
        Remove("Ito");

        //3回目の投票
        students[student17].VoteName = "Tanaka";
        require(ValidCandidate(student17));
        Remove("Tanaka");

        CandidateList.push(Candidate(4, "Okamoto")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(8, "Ito"));
        CandidateList.push(Candidate(5, "Tanaka"));
        students[student17].Orvoted = true; //投票完了

        address student18; //投票者18人目
        GiveRight(student18); //投票権を受け取る
        //1回目の投票
        students[student18].VoteName = "Yamashita";
        require(ValidCandidate(student18)); //候補者リストにある名前かどうかチェック
        Remove("Yamashita"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student18].VoteName = "Ito"; //上記の繰り返し
        require(ValidCandidate(student18));
        Remove("Ito");

        //3回目の投票
        students[student18].VoteName = "Takahashi";
        require(ValidCandidate(student18));
        Remove("Takahashi");

        CandidateList.push(Candidate(6, "Yamashita")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(9, "Ito"));
        CandidateList.push(Candidate(6, "Takahashi"));
        students[student18].Orvoted = true; //投票完了

        address student19; //投票者19人目
        GiveRight(student19); //投票権を受け取る
        //1回目の投票
        students[student19].VoteName = "Sato";
        require(ValidCandidate(student19)); //候補者リストにある名前かどうかチェック
        Remove("Sato"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student19].VoteName = "Tani"; //上記の繰り返し
        require(ValidCandidate(student19));
        Remove("Tani");

        //3回目の投票
        students[student19].VoteName = "Nakamura";
        require(ValidCandidate(student19));
        Remove("Nakamura");

        CandidateList.push(Candidate(8, "Sato")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(6, "Tani"));
        CandidateList.push(Candidate(5, "Nakamura"));
        students[student19].Orvoted = true; //投票完了

        address student20; //投票者20人目
        GiveRight(student20); //投票権を受け取る
        //1回目の投票
        students[student20].VoteName = "Ito";
        require(ValidCandidate(student20)); //候補者リストにある名前かどうかチェック
        Remove("Ito"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student20].VoteName = "Nakamura"; //上記の繰り返し
        require(ValidCandidate(student20));
        Remove("Nakamura");

        //3回目の投票
        students[student20].VoteName = "Kato";
        require(ValidCandidate(student20));
        Remove("Kato");

        CandidateList.push(Candidate(10, "Ito")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(6, "Nakamura"));
        CandidateList.push(Candidate(5, "Kato"));
        students[student20].Orvoted = true; //投票完了

        address student21; //投票者21人目
        GiveRight(student21); //投票権を受け取る
        //1回目の投票
        students[student21].VoteName = "Ito";
        require(ValidCandidate(student21)); //候補者リストにある名前かどうかチェック
        Remove("Ito"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student21].VoteName = "Matsumoto"; //上記の繰り返し
        require(ValidCandidate(student21));
        Remove("Matsumoto");

        //3回目の投票
        students[student21].VoteName = "Okamoto";
        require(ValidCandidate(student21));
        Remove("Okamoto");

        CandidateList.push(Candidate(11, "Ito")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(6, "Matsumoto"));
        CandidateList.push(Candidate(5, "Okamoto"));
        students[student21].Orvoted = true; //投票完了

        address student22; //投票者22人目
        GiveRight(student22); //投票権を受け取る
        //1回目の投票
        students[student22].VoteName = "Tani";
        require(ValidCandidate(student22)); //候補者リストにある名前かどうかチェック
        Remove("Tani"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student22].VoteName = "Tanaka"; //上記の繰り返し
        require(ValidCandidate(student22));
        Remove("Tanaka");

        //3回目の投票
        students[student22].VoteName = "Yamashita";
        require(ValidCandidate(student22));
        Remove("Yamashita");

        CandidateList.push(Candidate(7, "Tani")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(6, "Tanaka"));
        CandidateList.push(Candidate(7, "Yamashita"));
        students[student22].Orvoted = true; //投票完了

        address student23; //投票者23人目
        GiveRight(student23); //投票権を受け取る
        //1回目の投票
        students[student23].VoteName = "Okamoto";
        require(ValidCandidate(student23)); //候補者リストにある名前かどうかチェック
        Remove("Okamoto"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student23].VoteName = "Kato"; //上記の繰り返し
        require(ValidCandidate(student23));
        Remove("Kato");

        //3回目の投票
        students[student23].VoteName = "Takahashi";
        require(ValidCandidate(student23));
        Remove("Takahashi");

        CandidateList.push(Candidate(6, "Okamoto")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(6, "Kato"));
        CandidateList.push(Candidate(7, "Takahashi"));
        students[student23].Orvoted = true; //投票完了

        address student24; //投票者24人目
        GiveRight(student24); //投票権を受け取る
        //1回目の投票
        students[student24].VoteName = "Tani";
        require(ValidCandidate(student24)); //候補者リストにある名前かどうかチェック
        Remove("Tani"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student24].VoteName = "Sato"; //上記の繰り返し
        require(ValidCandidate(student24));
        Remove("Sato");

        //3回目の投票
        students[student24].VoteName = "Matsumoto";
        require(ValidCandidate(student24));
        Remove("Matsumoto");

        CandidateList.push(Candidate(8, "Tani")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(9, "Sato"));
        CandidateList.push(Candidate(7, "Matsumoto"));
        students[student24].Orvoted = true; //投票完了

        address student25; //投票者25人目
        GiveRight(student25); //投票権を受け取る
        //1回目の投票
        students[student25].VoteName = "Ito";
        require(ValidCandidate(student25)); //候補者リストにある名前かどうかチェック
        Remove("Ito"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student25].VoteName = "Sato"; //上記の繰り返し
        require(ValidCandidate(student25));
        Remove("Sato");

        //3回目の投票
        students[student25].VoteName = "Nakamura";
        require(ValidCandidate(student25));
        Remove("Nakamura");

        CandidateList.push(Candidate(12, "Ito")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(10, "Sato"));
        CandidateList.push(Candidate(7, "Nakamura"));
        students[student25].Orvoted = true; //投票完了

        address student26; //投票者26人目
        GiveRight(student26); //投票権を受け取る
        //1回目の投票
        students[student26].VoteName = "Tani";
        require(ValidCandidate(student26)); //候補者リストにある名前かどうかチェック
        Remove("Tani"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student26].VoteName = "Yamashita"; //上記の繰り返し
        require(ValidCandidate(student26));
        Remove("Yamashita");

        //3回目の投票
        students[student26].VoteName = "Kato";
        require(ValidCandidate(student26));
        Remove("Kato");

        CandidateList.push(Candidate(9, "Tani")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(8, "Yamashita"));
        CandidateList.push(Candidate(7, "Kato"));
        students[student26].Orvoted = true; //投票完了

        address student27; //投票者27人目
        GiveRight(student27); //投票権を受け取る
        //1回目の投票
        students[student27].VoteName = "Tani";
        require(ValidCandidate(student27)); //候補者リストにある名前かどうかチェック
        Remove("Tani"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student27].VoteName = "Ito"; //上記の繰り返し
        require(ValidCandidate(student27));
        Remove("Ito");

        //3回目の投票
        students[student27].VoteName = "Okamoto";
        require(ValidCandidate(student27));
        Remove("Okamoto");

        CandidateList.push(Candidate(10, "Tani")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(13, "Ito"));
        CandidateList.push(Candidate(7, "Okamoto"));
        students[student27].Orvoted = true; //投票完了

        address student28; //投票者28人目
        GiveRight(student28); //投票権を受け取る
        //1回目の投票
        students[student28].VoteName = "Sato";
        require(ValidCandidate(student28)); //候補者リストにある名前かどうかチェック
        Remove("Sato"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student28].VoteName = "Matsumoto"; //上記の繰り返し
        require(ValidCandidate(student28));
        Remove("Matsumoto");

        //3回目の投票
        students[student28].VoteName = "Tanaka";
        require(ValidCandidate(student28));
        Remove("Tanaka");

        CandidateList.push(Candidate(11, "Sato")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(8, "Matsumoto"));
        CandidateList.push(Candidate(7, "Tanaka"));
        students[student28].Orvoted = true; //投票完了

        address student29; //投票者29人目
        GiveRight(student29); //投票権を受け取る
        //1回目の投票
        students[student29].VoteName = "Ito";
        require(ValidCandidate(student29)); //候補者リストにある名前かどうかチェック
        Remove("Ito"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student29].VoteName = "Kato"; //上記の繰り返し
        require(ValidCandidate(student29));
        Remove("Kato");

        //3回目の投票
        students[student29].VoteName = "Takahashi";
        require(ValidCandidate(student29));
        Remove("Takahashi");

        CandidateList.push(Candidate(14, "Ito")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(8, "Kato"));
        CandidateList.push(Candidate(9, "Takahashi"));
        students[student29].Orvoted = true; //投票完了

        address student30; //投票者30人目
        GiveRight(student30); //投票権を受け取る
        //1回目の投票
        students[student30].VoteName = "Sato";
        require(ValidCandidate(student30)); //候補者リストにある名前かどうかチェック
        Remove("Sato"); //投票した候補者をリストから消す      

        //2回目の投票
        students[student30].VoteName = "Nakamura"; //上記の繰り返し
        require(ValidCandidate(student30));
        Remove("Nakamura");

        //3回目の投票
        students[student30].VoteName = "Yamashita";
        require(ValidCandidate(student30));
        Remove("Yamashita");

        CandidateList.push(Candidate(12, "Sato")); //投票先の候補者の得票数を増やしてリストに追加する
        CandidateList.push(Candidate(8, "Nakamura"));
        CandidateList.push(Candidate(9, "Yamashita"));
        students[student30].Orvoted = true; //投票完了

        sort(CandidateList); //得票数の結果を昇順に並び替える
    }

    //投票した候補者を一時的にリストから取り除く
    function Remove(string memory name) public {
        for(uint p = 0; p < CandidateList.length; p++) {
            if(keccak256(abi.encodePacked(CandidateList[p].Name)) == keccak256(abi.encodePacked(name))) {
                delete CandidateList[p];
            }
        }
    }

    //投票先の名前と候補者名が一致しているかどうか
    function ValidCandidate(address student) view public returns (bool) { //投票者が書いた名前がCandidateListの中に存在するか比較して判定する
        for(uint i = 0; i < CandidateList.length; i++) {
            if (keccak256(abi.encodePacked(CandidateList[i].Name)) == keccak256(abi.encodePacked(students[student].VoteName))) { 
                return true;
            }
        }
        return false;
    }

    //クイックソートの呼び出し
    function sort(Candidate[] memory) public returns (Candidate[] memory) {
        quickSort(CandidateList, 0, CandidateList.length - 1);
        return CandidateList;
    }

    //集計結果を昇順に並び替え（クイックソート）
    function quickSort(Candidate[] memory sub, uint left, uint right) internal {
        uint s = left;
        uint t = right;
        if (s < t) {
            uint pivot = sub[uint((left + right) / 2)].VotesReceived;

            while(s <= t) {
                while (sub[uint(s)].VotesReceived < pivot) {
                    s++;
                }
                while (pivot < sub[uint(t)].VotesReceived) {
                    t--;
                }
                if (s <= t) {
                    (sub[uint(s)].VotesReceived, sub[uint(t)].VotesReceived) = (sub[uint(t)].VotesReceived, sub[uint(s)].VotesReceived);
                        s++;
                        t--;
                    }
            }
            if (left < t) {
                quickSort(sub, left, t);
            }
            if (s < right) {
                quickSort(sub, s, right);
            }    
        }
    }  
}

class JukenController < ApplicationController
    def search; end

    def result
        # 初期値

        @year = 3
        @types = "\u7406\u7CFB"
        @universitys = "\u65E9\u6176\u56FD\u516C\u7ACB\u975E\u533B"
        @deviations = '41~50'
        @times = '4時間以上'
        @layouts = "文字多め"
        @excercises = "問題量重視"



        # 値の習得

        unless params[:state].nil?
            @year = params[:state][:year].to_i
            @types = params[:state][:type]
            @universitys = params[:state][:university]
            @deviations = params[:state][:deviation]
            @times = params[:state][:time]
            @layouts = params[:state][:layout]
            @excercises = params[:state][:excercise]
        end

        # 代入値の数値化

        case @types
        when "\u6587\u7CFB" then
            @type = 1
        when "\u7406\u7CFB" then
            @type = 2
        end
        case @universitys
        when "\u6771\u5927\u30FB\u4EAC\u5927\u30FB\u533B\u5B66\u90E8" then
            @university = 1
        when "\u65E9\u6176\u56FD\u516C\u7ACB\u975E\u533B" then
            @university = 2
        when "MARCH\u30EC\u30D9\u30EB" then
            @university = 3
        when 'その他' then
            @university = 4
        end
        case @deviations
        when '~40' then
            @deviation = 1
        when '41~50' then
            @deviation = 2
        when '51~60' then
            @deviation = 3
        when '61~70' then
            @deviation = 4
        when '71~' then
            @deviation = 5
        end
        case @times
        when "1時間未満" then
            @time = 1
        when "1~2\u6642\u9593" then
            @time = 2
        when "2~3\u6642\u9593" then
            @time = 3
        when "3~4\u6642\u9593" then
            @time = 4
        when "4時間以上" then
            @time = 5
        end
        case @layouts
        when "文字多め" then
            @layout = 1
        when "そこそこ文字多め" then
            @layout = 2
        when "普通" then
            @layout = 3
        when "そこそこ図多め" then
            @layout = 4
        when "図多め" then
            @layout = 5
        end
        case @excercises
        when "問題量重視" then
            @excercise = 1
        when "そこそこ問題量重視" then
            @excercise = 2
        when "普通" then
            @excercise = 3
        when "そこそこ解説重視" then
            @excercise = 4
        when "解説重視" then
            @excercise = 5
        end

        #テスト用
=begin
        @year = rand(3) + 1
        @type = rand(2) + 1
        @university = rand(4) + 1
        @deviation = rand(5) + 1
        @time = rand(5) + 1
        @layout = rand(5) + 1
        @excercise = rand(5) + 1

=end





        # 期間の記入

        if @year == 1
            @message1 = '高1'
            @message2 = '高2前半'
            @message3 = '高2後半'
            @message4 = '高3：4～6月'
        elsif @year == 2
            @message1 = '高2前半'
            @message2 = '高2後半'
            @message3 = '高3：4～6月'
            @message4 = '高3：7～9月'
        elsif @year == 3
            @message1 = '高3：4～6月'
            @message2 = '高3：7～9月'
            @message3 = '高3：10~12月'
            @message4 = '高3：1,2月'
        end

        # 評価関数

        def eva(num, book)
            sum = 0

            own_achieve = @deviation.to_f * (8 - 2 * num) / 10 + (5 - @university).to_f * 2 * (num + 1) / 10

            sum -= (book[:level] - (num + own_achieve + (@year - 3)))**2

            sum -= (((@type - 1) * 2 + 1 - book[:hands])**2)*2

            sum -= (book[:layout] - @layout)**2

            sum -= (book[:const] - @excercise)**2

            sum -= ((book[:page] - @time * 100)**2) / 10000

            return    sum
        end

        # 評価値の比較

        @book = []
        @maxevaluation = []
        4.times do |j|
            Book.count.times do |i|
                book = Book.find(i + 1)

                evaluation = eva(j, book)
                if i == 0 && j == 0
                    @maxevaluation[j] = evaluation
                    @book[j] = book
                    next
                end

                # 重複の防止

                c = 0
                j.times do |k|
                    c = 1 if book == @book[j - k - 1]
                end
                next if c == 1

                if @maxevaluation[j].nil?
                    @maxevaluation[j] = evaluation
                    @book[j] = book
                end

                if @maxevaluation[j] < evaluation
                    @maxevaluation[j] = evaluation
                    @book[j] = book
                end
            end
        end
    end
end

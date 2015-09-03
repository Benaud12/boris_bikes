
require "docking_station"

describe DockingStation do
	it { is_expected.to respond_to (:release_bike) }


	it 'releases working bikes' do
		subject.dock Bike.new
		bike = subject.release_bike
		expect(bike).to be_working
	end

	it { is_expected.to respond_to(:dock).with(1).argument }

	describe '#release_bike' do
		it 'raises an error when there are no bikes available' do
			expect { subject.release_bike }.to raise_error 'No bikes available'
		end
		it 'raises an error when there is only one broken bike available' do
			bike_new = Bike.new
			bike_new.report_broken
			subject.dock bike_new
			expect{subject.release_bike}.to raise_error 'No bikes available'
		end
		it 'raises an error only if no working bikes available' do
			bike1 = Bike.new
			bike2 = Bike.new
			bike2.report_broken
			subject.dock bike1
			subject.dock bike2
			expect{subject.release_bike}.not_to raise_error
		end
		it 'not to release broken bikes' do
			bike1 = Bike.new
			bike2 = Bike.new
			bike2.report_broken
			subject.dock bike1
			subject.dock bike2
			my_bike = subject.release_bike
			expect(my_bike).to be_working
		end
	end

	describe '#dock' do
		it 'raises an error when full' do
			station1 = DockingStation.new
			station1.capacity.times{station1.dock(Bike.new)}
			expect{ station1.dock Bike.new }.to raise_error 'Docking station full'
		end
	end

	it do
		station = DockingStation.new
		expect(station.capacity).to eq DockingStation::DEFAULT_CAPACITY
	end

	it do
		expect(subject).to respond_to(:capacity=).with(1).argument
	end


end 

